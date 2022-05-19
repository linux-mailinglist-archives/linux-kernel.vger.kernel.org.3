Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B885052E0D1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343742AbiESXtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231489AbiESXtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:49:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F81F51E60
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:49:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so9290029wrg.12
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y0oCJ7eVklYU5ISMLpAljLf1EhsBiI+TUBhdkiRoUVg=;
        b=pfat2u2dPri+xKpJXPyasmqlI45mteoXMh1L7cRS4WMoQHtyfaWPWOx3GyLwygL7nU
         xTXCc6VSuasuntd0KQqRI4yOYRv/hznIslJUA+F3MOC5L7pE24s4tzdqJ0tm98KiOxwL
         bNmBydfPqt5JxyU0F77kAxB8B2u+YsWhWia2YGFcQoYYnH8qqhYH8qmTvcQuXbXvztoi
         qksNOFUSLdXGhJbss+KkPnHJbz+lKiPPLTG5faSGcPZtjRb9qMVLY+OiwssOhoqkfaB6
         XHBuaK4zxI9Z9uf5c3HuIlJoVG4G4MvZ0b/X59FOZVGT60wQM8VKtBtIGHDN5NueQWHW
         yd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0oCJ7eVklYU5ISMLpAljLf1EhsBiI+TUBhdkiRoUVg=;
        b=hk118sIo4PdNdh9tKBVDUgqYdaVOS5OcPYyMabHgM/1bufEL19CVVOCxxT87S1lS+s
         KiWv9dSSF5lzVM3KqYBEHYzwAzgjcGKHaDvEv4/7v4OV8jAcN2UHBrrZSuKi5rc2gpWS
         ULAUIT4zp8LcLXOJQoqOn7gXVnEwSU348sMzHQzjLvi9kr4fsl9Y9OBgz74j9fnGwIAQ
         4NOauFdPkfCSBQF2I50Qhu11/YwKCv1cKpCi8bD3TmZUWdbY9FANZTipFQ+zWCuGbQ7o
         pl3Amc7aO4V55dluPqEmGyLBTo1iUUmincei4ICM8NbX244qLFgTPWyXpZG1nrp77St2
         wyVg==
X-Gm-Message-State: AOAM5322VVP+0WKZ3EKoQGfe8E5GAUzx4tOz0up3yJS/vlg8HZ1Kh4UT
        gdtjO1iUND4JJO3zXiKXSm9R/8WXTmMg9QjQdMH4+g==
X-Google-Smtp-Source: ABdhPJzBNMNUR5pC8I5fNCJ4ZrGE+WO7njBavHiokXbKplP+1DGWwWbRRt2zXE1iRhdWZZt9A69h8Ne0WBttbXQpXHc=
X-Received: by 2002:adf:e70e:0:b0:20e:7523:f01d with SMTP id
 c14-20020adfe70e000000b0020e7523f01dmr1757597wrm.300.1653004145679; Thu, 19
 May 2022 16:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220519054355.477-1-ravi.bangoria@amd.com> <20220519054355.477-5-ravi.bangoria@amd.com>
In-Reply-To: <20220519054355.477-5-ravi.bangoria@amd.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 May 2022 16:48:51 -0700
Message-ID: <CAP-5=fU5ArsMcTiYNgZ1U+i6mmtdc+OGx9_ny0x46+O7d4+dpQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] perf tool ibs: Sync amd ibs header file
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, peterz@infradead.org, rrichter@amd.com,
        mingo@redhat.com, mark.rutland@arm.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        james.clark@arm.com, leo.yan@linaro.org, kan.liang@linux.intel.com,
        ak@linux.intel.com, eranian@google.com, like.xu.linux@gmail.com,
        x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 10:45 PM Ravi Bangoria <ravi.bangoria@amd.com> wrote:
>
> IBS support has been enhanced with two new features in upcoming uarch:
> 1. DataSrc extension and 2. L3 miss filtering. Additional set of bits
> has been introduced in IBS registers to exploit these features.
> New bits are already defining in arch/x86/ header. Sync it with tools
> header file.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  tools/arch/x86/include/asm/amd-ibs.h | 16 ++++++++++------
>  tools/perf/util/amd-sample-raw.c     |  4 ++--
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/tools/arch/x86/include/asm/amd-ibs.h b/tools/arch/x86/include/asm/amd-ibs.h
> index 765e9e752d03..9a3312e12e2e 100644
> --- a/tools/arch/x86/include/asm/amd-ibs.h
> +++ b/tools/arch/x86/include/asm/amd-ibs.h
> @@ -29,7 +29,10 @@ union ibs_fetch_ctl {
>                         rand_en:1,      /* 57: random tagging enable */
>                         fetch_l2_miss:1,/* 58: L2 miss for sampled fetch
>                                          *      (needs IbsFetchComp) */
> -                       reserved:5;     /* 59-63: reserved */
> +                       l3_miss_only:1, /* 59: Collect L3 miss samples only */
> +                       fetch_oc_miss:1,/* 60: Op cache miss for the sampled fetch */
> +                       fetch_l3_miss:1,/* 61: L3 cache miss for the sampled fetch */
> +                       reserved:2;     /* 62-63: reserved */
>         };
>  };
>
> @@ -38,14 +41,14 @@ union ibs_op_ctl {
>         __u64 val;
>         struct {
>                 __u64   opmaxcnt:16,    /* 0-15: periodic op max. count */
> -                       reserved0:1,    /* 16: reserved */
> +                       l3_miss_only:1, /* 16: Collect L3 miss samples only */
>                         op_en:1,        /* 17: op sampling enable */
>                         op_val:1,       /* 18: op sample valid */
>                         cnt_ctl:1,      /* 19: periodic op counter control */
>                         opmaxcnt_ext:7, /* 20-26: upper 7 bits of periodic op maximum count */
> -                       reserved1:5,    /* 27-31: reserved */
> +                       reserved0:5,    /* 27-31: reserved */
>                         opcurcnt:27,    /* 32-58: periodic op counter current count */
> -                       reserved2:5;    /* 59-63: reserved */
> +                       reserved1:5;    /* 59-63: reserved */
>         };
>  };
>
> @@ -71,11 +74,12 @@ union ibs_op_data {
>  union ibs_op_data2 {
>         __u64 val;
>         struct {
> -               __u64   data_src:3,     /* 0-2: data source */
> +               __u64   data_src_lo:3,  /* 0-2: data source low */
>                         reserved0:1,    /* 3: reserved */
>                         rmt_node:1,     /* 4: destination node */
>                         cache_hit_st:1, /* 5: cache hit state */
> -                       reserved1:57;   /* 5-63: reserved */
> +                       data_src_hi:2,  /* 6-7: data source high */
> +                       reserved1:56;   /* 8-63: reserved */
>         };
>  };
>
> diff --git a/tools/perf/util/amd-sample-raw.c b/tools/perf/util/amd-sample-raw.c
> index d19d765195c5..3b623ea6ee7e 100644
> --- a/tools/perf/util/amd-sample-raw.c
> +++ b/tools/perf/util/amd-sample-raw.c

nit: given the commit message this should probably be a separate patch.

Thanks,
Ian

> @@ -98,9 +98,9 @@ static void pr_ibs_op_data2(union ibs_op_data2 reg)
>         };
>
>         printf("ibs_op_data2:\t%016llx %sRmtNode %d%s\n", reg.val,
> -              reg.data_src == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
> +              reg.data_src_lo == 2 ? (reg.cache_hit_st ? "CacheHitSt 1=O-State "
>                                                      : "CacheHitSt 0=M-state ") : "",
> -              reg.rmt_node, data_src_str[reg.data_src]);
> +              reg.rmt_node, data_src_str[reg.data_src_lo]);
>  }
>
>  static void pr_ibs_op_data3(union ibs_op_data3 reg)
> --
> 2.27.0
>
