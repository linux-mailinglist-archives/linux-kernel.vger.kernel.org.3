Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542045AE5F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233424AbiIFKyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240034AbiIFKx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:53:26 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677181CB22
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 03:52:23 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11e9a7135easo27149318fac.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 03:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=riAAiaIh0oEv62FPyBl3UL0jQXDZKALZcUDPeGDRNBs=;
        b=IHWCxpbsJ0QmftOVVUlxVHoMCCiavK8xuYat/Tc5X3KlArMPmsqhiBij1IwK9RRRWZ
         iMwvw04b5LBEcvHQ69rN2N/qu+8dtgJhVNHeBrCOmslf+5DZXiu7eSQc+AFp8s86xkJi
         tpwHYau/efuA8DhPjyEOsIOpRCH6XXVQzFggB89yGC7boLfXWa1tOovDemCRzynO9LJ7
         JCekd97HbKqTPmY5OtUL2fT+nxoz/OcAjTvT9Vu3CpNt0UwbyxD/ZdId4AicNTCwksSi
         6p8AcfXrxWGN6viCZjsuUIixv5twsGx8T8+83PBkUgl4lHxuCNgoFNKTsMRTdD2I+NJM
         aC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=riAAiaIh0oEv62FPyBl3UL0jQXDZKALZcUDPeGDRNBs=;
        b=724CRDiA8T27/Kby8ub6Bk3rZ4Tf9Vs6wd6EHuvRKrPiNahrCJXugeyE4LM5HYmCpv
         MQwL9Ks8UPRDGAa4z9SzNMSaGEfrJ60+HvC6ohW618oq+mFtmWvq3Wb2BC/DM8RdU/GO
         wmbPqHjTXbS+wGDSd79qQ92OdFSM0l8WwIWv7VURN7YeOkjnR0MjGHUC8eCRdFieHTyF
         J3pDEK8XWzI9LNiPwLp/bsYjf+/6igcs8jdzdWYYX0aB4umxsuEuV2ez2Wfdztn4iDWo
         vX8LSBG9M1kJ8pkRsDt6+TRZSkB0Ca5HKraXJVhfSDIbtSTWJkdoSaOlkmRiKM/aWMoF
         XqNA==
X-Gm-Message-State: ACgBeo2xa7LAdyxcRx+dq6rFqIeXBAkYtxDqGTOsT7leyiP1+Pubv7DJ
        u02WmmnNvk9Kng08clTm+t+6Zi0nCfElzMc8IOXKjNVq1o4=
X-Google-Smtp-Source: AA6agR7aM1W7eko8L8TCWV2oJ0SENxPUj3ypb5bFGFMnJytflPS2c04WQ2EC0VjnYKFrEzxxywd22aSRIVlyPPVU6Nk=
X-Received: by 2002:a05:6808:e90:b0:345:49f2:a112 with SMTP id
 k16-20020a0568080e9000b0034549f2a112mr9785518oil.7.1662461542712; Tue, 06 Sep
 2022 03:52:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662454215.git.cmo@melexis.com> <32c4b72624e4a3480b202f24f506ca91029e47f7.1662454215.git.cmo@melexis.com>
 <CAHp75VezNufWGW6sC+ALmX9H4yavWRCmpHuv9ZVoRycQxZ-uQg@mail.gmail.com>
In-Reply-To: <CAHp75VezNufWGW6sC+ALmX9H4yavWRCmpHuv9ZVoRycQxZ-uQg@mail.gmail.com>
From:   Crt Mori <cmo@melexis.com>
Date:   Tue, 6 Sep 2022 12:51:46 +0200
Message-ID: <CAKv63utD2NzbUYR2=rrmZtkdtwOzoQBW7dZ5yzNa-r8uKmqXaw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sept 2022 at 12:21, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> Very good and documented code, thanks!
> I believe you better to use DEFINE_.*_PM_OPS instead of legacy ones
> (due to pm_ptr() usage).
> Otherwise, with some nitpicks that wouldn't prevent a green light,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
I checked DEFINE_.*_PM_OPS usage around drivers and you either have
SIMPLE (where you define suspend/resume) or you have RUNTIME (for
runtime suspend/resume), but never are those two together. So I am a
bit puzzled how to get this working.
