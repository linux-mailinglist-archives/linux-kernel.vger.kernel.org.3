Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2F24D1057
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbiCHGeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCHGeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:34:05 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C7B3A70C;
        Mon,  7 Mar 2022 22:33:10 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id bc27so15595552pgb.4;
        Mon, 07 Mar 2022 22:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hMjnxV0GnFj2CSor8E3F7ywKx8ZqWT73m+9Cg9mTc0I=;
        b=SLdxROCW6cr3FHmNOHAdjkeIc8HSPqIauQwbKl06rFdvYwydIfxdCuzSumG9QQcDJc
         K+VSXhaQaSUh09zI60t2vuH1BgCyUy0iuQ1wPpR/ucWsmcC4LvUZ4nNWOVWZmod8BDeY
         hgSgKiW9vNbYk6BNWeB9gE+aiz1HBTQD4E/pH/gpnCIYWTntMiBj4uYwGUmugiSZZZa3
         3t+g+iRBngfe7q85VOKTu4lrDzWeZnb4waJrKtkHV78xCGD/04kLcBgtxhrCYAC966n9
         9LcRa2Xx5q7buYyo7hhS6xhZTyvjCNAVtUaUzECkVdJ3dMORTaM9kkRQO1PPBYlMHoE5
         uLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hMjnxV0GnFj2CSor8E3F7ywKx8ZqWT73m+9Cg9mTc0I=;
        b=6ktfS//RouT6r7vdlQrDFCbAHkQeXI3i0pHKKdOrHDE3MCrLEO+tPYnFaM4WJyx2Xe
         YtpiXBuSqrtPGRAor4Jo5wH5ne4MLek6iv52I6EzDh4XU1gB8TX1EkQIimDLnU+CWkiy
         D8/9VzDuHYna8UaOjzSqok3fk5hE0cq2xnuM47vcXq4ZpmanRlt0E8QRkKD3HtqnBwFm
         T87aEHJrdgD9kalZUyDQxOo21YjfK9MeC2nRedgfjwHf1FVWBlMhFCjO6p70lLh5AVOs
         vc1FbxMf2orj2D192rFtKbGM8vi/A3LKJPb7cYcHZIQbVR2MAX2Uii0DEAVnCywVNSda
         8lUA==
X-Gm-Message-State: AOAM531wffaM4dGQHOGH5Sa/JHAJEPEzDBarDVKXWqDk593wuMI2wDjs
        06z+s/iuKRSZLDkrvj+Tqh4=
X-Google-Smtp-Source: ABdhPJzM074HV5/+qzKqbSEKkUCYmOGcd3K7CQJbyJDhO2N3GuyVvwZHiiPbJmprB2u0EkXiohKqTQ==
X-Received: by 2002:a65:43c8:0:b0:378:7add:ec4c with SMTP id n8-20020a6543c8000000b003787addec4cmr12509854pgp.570.1646721189783;
        Mon, 07 Mar 2022 22:33:09 -0800 (PST)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id z16-20020a056a00241000b004f3a647ae89sm18559292pfh.174.2022.03.07.22.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:33:09 -0800 (PST)
Date:   Tue, 8 Mar 2022 12:03:04 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm: dts: realview/versatile/ste: Update spi clock
 name
Message-ID: <20220308063304.GA67419@9a2d8922b8f1>
References: <20220307205357.66322-1-singh.kuldeep87k@gmail.com>
 <20220307205357.66322-2-singh.kuldeep87k@gmail.com>
 <CAL_JsqKrq-NtkPF=p8Qn-_63qE80_0FSQkbY5WxCfJUcrNxJuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKrq-NtkPF=p8Qn-_63qE80_0FSQkbY5WxCfJUcrNxJuA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 07:14:09PM -0600, Rob Herring wrote:
> On Mon, Mar 7, 2022 at 2:54 PM Kuldeep Singh <singh.kuldeep87k@gmail.com> wrote:
> >
> > SPI clock for pl022 is "sspclk" and meanwhile few platforms such as
> > realview, versatile etc. specify "SSPCLK" as clock name. Even though
> > bindings checks don't differentiate between the two names still keep
> > same convention throughout i.e sspclk to align with other platforms.
> 
> I don't see the point in worrying about this. The binding already
> allows both. Why? Because I wrote the schema and checked it against
> all the in tree users. The resulting warnings are what should be fixed
> in the dts files IMO. What's not warning doesn't need to be fixed.

Hi Rob,

I personally share a different opinion though. Kindly bear with me for
my explanations.

As there were no checks on DTs before, so DTs have been defining names
which may not align with bindings. In case of pl022, doc says sspclk is
connected clock and whereas binding specify SSPCLK and sspclk both. Why
keep both versions in bindings? just because DTs have it. I don't think
it's justifiable enough and that's what prompted me to keep single
entry. Please let me know in case my understanding is incorrect.

I kept "sspclk" as it is aligned with "apb_pclk" and I have not seen
many DT defining names in caps.

Moreover, I ran out few checks and came up with some observations:
	1. Keep SSPCLK in binding, 'make dtbs_check' doesn't complain. An
	obvious behavior.
	2. Remove SSPCLK from binding, 'make dtbs_check' again doesn't
	complain.

For 2), though binding doesn't have SSPCLK, still DTs with clock-name
SSPCLK do not complain which further leads me to conclusion that casing
is not considered while comparing. So, why should we keep both and can't
simply discard other one.

This may not be a concern as per warnings point of view, but let's say
in future comparison checks get even more stricter, then this will roll
out as a warning and needs to be looked again. Why shall we leave out a
chance which may need to be revisited later?

Regards
Kuldeep
