Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F7E58CD15
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243952AbiHHRzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbiHHRzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:55:22 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7AC2AD8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 10:55:21 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g12so8739125pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=AndoNn3ZwU210Wyi4m1ND/gRkTyAXTkRJXpmCYwRvFw=;
        b=g9xPtgh547zk5MwKl46YtVJiNoFDxPx4x0UHsV2NxBq/1/kYGR0GF4tK4DYPbojuA8
         daNUon1xOn8Mv480K3NFJswZ912sYvgi2mnZZFAqhEMD7JX+ZHFHs96HUVm9fzlOtzVk
         5N4SxAufszUQoDWljaB5vCyhvBakDLF10ljicwYByztg4clRSY1tk/Jx+qVQdfaV10/I
         lLpK5xwLUkZZESlOLIBBC/Y2TxDSxppZ1ZILsDs+iIGds24EAScbR6Btf1f0NCCSHLO2
         z4PxEN+iX7MLq+1O1lzMYwPl8HAXrhUl2x5IimgWyT5njfAgVrNrnrpELbsK/CFPnpUM
         sBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=AndoNn3ZwU210Wyi4m1ND/gRkTyAXTkRJXpmCYwRvFw=;
        b=nM6F2Wc/SWEKvlmOp5u5fPRAWX2UJNwYWD0B8qI1PhKb0401i5bG81KiJl9L813nnA
         GxrHyskrgyKmoSRzxzmCBnPG/G+YDL3AimqbbpV7JDLYjejcgPtcSPfWPvHeeYrT8+UK
         f1795P+Sg/j5cpRPRveUBym6N5cXm7yTO+1LOXwInHONziJDJjKi9o/nidPVjhJAh1AV
         c5fiF5Mfmx3+zTlhx8epwTB6kPIu9U+IJYFNq40/ebe91xvW3Cg+mNYD6/K2dCJ/1bZ8
         KSGXVm8fOJuCM5mCJAtvI7WJeNWQ821ggc5geq0rlMsvO3lu8WXtrTr1WL9UOqMYBblT
         ceZA==
X-Gm-Message-State: ACgBeo1xaBiDy09Osl5DX3J7MJgh3u7peT+eZ3oLx2qqo1klx4rMsXF6
        7INlmb9SW59Z9ULX1eEmcaOeA4zWngzO61CNNmFEWK7y
X-Google-Smtp-Source: AA6agR69l6hhr5+S/alatCxRuN+mF4m1wb9zS3xgny6HPi8iNz7In9pgSV2YtPnfjHV5McH4/7hPj2lQ4s+p7m8oi64=
X-Received: by 2002:a65:5503:0:b0:41b:bbdc:9a5d with SMTP id
 f3-20020a655503000000b0041bbbdc9a5dmr15953418pgr.587.1659981321257; Mon, 08
 Aug 2022 10:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220805184016.2926168-1-alexlzhu@fb.com> <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com> <Yu1uabedm+NYnnAj@casper.infradead.org>
 <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com>
In-Reply-To: <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 8 Aug 2022 10:55:09 -0700
Message-ID: <CAHbLzkp27aP4JYLPLzv2vtyzVe63bkhuZhw1jnxTF1Buvt4rew@mail.gmail.com>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to /proc/thp_utilization
To:     "Alex Zhu (Kernel)" <alexlzhu@fb.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 5, 2022 at 12:52 PM Alex Zhu (Kernel) <alexlzhu@fb.com> wrote:
>
>
> >
> > Ah!  So when that exists, this interface tells us "how well" we're doin=
g.
> >
>
> Yes, exactly.
> >
> > Yeah, debugfs seems like a better place.  And I'd love to see the shrin=
ker
> > code.  Before you mentioned that I was having all kinds of peculiar
> > feelings about this code.  For example, suppose you have incredibly hot
> > 256kB of data, but the other 1792kB of data are never touched ... that
> > could cause us to do entirely the wrong thing and break up this THP.
> > Having it as a shrinker makes sense because the hot 256kB will keep the
> > THP from reaching the end of the list and being reclaimed.
>
> Sounds good, I=E2=80=99ll move this to debugfs then. Will follow up with =
the shrinker code
> in another patch. The shrinker relies on this scanning thread to figure o=
ut which
> THPs to reclaim.

I'm wondering whether you could reuse the THP deferred split shrinker
or not. It is already memcg aware.

>
> What are your thoughts regarding integrating this with DAMON?
