Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04A25AF674
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiIFU6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbiIFU6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:58:21 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDE5B9419;
        Tue,  6 Sep 2022 13:57:49 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e126so11844227ybh.1;
        Tue, 06 Sep 2022 13:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=jkzG4HHSHzfaT1CUe2Sl37GnDklYHWbN1sqPuco7wbU=;
        b=hnC+f2ZMzZJtX8gDp2ZMSrwIFn6nEHFjYnU6A2H0xxd+DyAEyntbAAUuA2bvFm/6gT
         IP4A+StS8OyREGCayiLei5kSZQbR/1bRbRwH5FASBYl2Y9i3UMFwlDz6mQ8lbMy7WqEh
         c+ig3lPeyxwZEkHW5iE2y6IqelaEoeGkSUUgPon2HzdeQ0hssbK1A1recKWBRhDLGwGU
         bCzMUF7O8ETOIhxuWT26+85IuKDAdmpD3Qu9ufD8uo1u9HKbYBL4g20RNhlpxdx8W+gL
         trSFqRfCXZ0LmsCceYXv1fl3FFWiIDNsJ/paIxBntaDoWDe/tho5QdkFPbw4pq+4fGIL
         /ThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=jkzG4HHSHzfaT1CUe2Sl37GnDklYHWbN1sqPuco7wbU=;
        b=NJWkddLh3QKMVp2JFhrK7GAd58U1IT1ZcxgxAByE9Go7LwfzDvzXVVCgSbho3dTY6o
         ogpJ1eVlu+4+DuC1XeOtS/Uzdx3RNdWu8OaQWE/5yzrLEngqBPQMzAoCnrbGqrRshJ5O
         lyAJEt21JAK5oQxPli7pm0TCu0FygOWfryybEo9T4fxvvUDYGYZ/rChlDGR5dmPiYk5r
         WNNC4FKMFn7B1APDdiW667LI2DtfF1/FmgZLs89sRjJwbwKIwf1c2w4CLsgUAL7DhRSQ
         oW7fhtYFoElc0zHGlyRlfdlmoZG6qJjfBVBinKRSUlmIhxycfAPBNo5JwcUIhq1JGXz8
         NvSA==
X-Gm-Message-State: ACgBeo2CH/ccRBZs/bYcLkB1CQ8LAkXYvdOlAKRHNw/6PhFQ2DefxF/q
        +0SWIsHhEi0eQ4r5UQUjaG+j3Sng5Lwwff8ec1/dR7tFV6ThJA==
X-Google-Smtp-Source: AA6agR7OG7DWtLeWGmLyD7UKW5D6RTKajsKz0KoBSFX89WWVijzL6Q3U87zMphnJtWACkDzecnyfmQr+GaQCg6fPUH8=
X-Received: by 2002:a25:3b46:0:b0:69c:a60e:2e57 with SMTP id
 i67-20020a253b46000000b0069ca60e2e57mr396769yba.364.1662497866247; Tue, 06
 Sep 2022 13:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <YxdZ/9XOsWilvVSd@debian> <44fe9ca0-e1d7-1e4f-9fd8-0f48a84dca72@marvell.com>
In-Reply-To: <44fe9ca0-e1d7-1e4f-9fd8-0f48a84dca72@marvell.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Tue, 6 Sep 2022 21:57:10 +0100
Message-ID: <CADVatmMsYk+tgJDASx2uoskLzY=b4m7SNo+3R6SXT=0vEnu+vA@mail.gmail.com>
Subject: Re: [EXT] build failure of next-20220906 due to 8bfc149ba24c ("scsi:
 qla2xxx: Enhance driver tracing with separate tunable and more")
To:     Arun Easi <aeasi@marvell.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Nilesh Javali <njavali@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 5:05 PM Arun Easi <aeasi@marvell.com> wrote:
>
> Hi Sudip,
>
> On Tue, 6 Sep 2022, 7:32am, Sudip Mukherjee (Codethink) wrote:
>
> > External Email
> >
> > ----------------------------------------------------------------------
> > Hi All,
> >
> > The builds of loongarch loongson3_defconfig have failed to build
> > next-20220906 with the error:
> >
> > drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_init':
> > drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'? [-Werror=implicit-function-declaration]
> >  2854 |         qla_trc_array = trace_array_get_by_name("qla2xxx");
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~
> >       |                         trace_array_set_clr_event
> >
> > drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_uninit':
> > drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function 'trace_array_put' [-Werror=implicit-function-declaration]
> >  2869 |         trace_array_put(qla_trc_array);
> >       |         ^~~~~~~~~~~~~~~
> >
> >
> > git bisect pointed to 8bfc149ba24c ("scsi: qla2xxx: Enhance driver tracing with separate tunable and more").
> >
> > I will be happy to test any patch or provide any extra log if needed.
> >
> >
>
> This looks like is happening due to CONFIG_TRACING not being enabled (same
> as what kernel test bot reported). Could you try out the fix attached?

Thanks, that fixed the build for me. The patch did not apply directly
on next-20220906, so I had to modify it a little bit.

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

-- 
Regards
Sudip
