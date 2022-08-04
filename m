Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D8558A1F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 22:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238472AbiHDUbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 16:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiHDUby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 16:31:54 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319B519293;
        Thu,  4 Aug 2022 13:31:53 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id g18so492405ilk.4;
        Thu, 04 Aug 2022 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXDBVb9DoiSymMWk0AFQK5uBRVXEjsO6eGZBfYrkcFM=;
        b=lAjmdOHyeQphpF1OcxVV1rVgcOMHU5AEAguiHRypsUJj8qTMRYq5BuHEl82rIjANCm
         EodS00O6wVT3Z2WWBn09fBLQqu15HuZRXXIttSvxvu6EvgwM1e1qDcCp7Y5eI9wEnyLs
         QZLQa5+VtX0oqQELCLoJosyL/qKNxu5+rgfmtkITeNhqnOAV2eMu8LOkwdaTyZhkXpEv
         GUCMebhrSl7TMcjAc6/ktQSNtVtzMuTXadjGBu2RLrfIGe3MWGPa6fn1n9pJWA8lSuwR
         luQ8VkFAAfKL8DVfcH1NPieDD5vIPNkN3vucWcBqgTFrulXRZWW3xkTGjqjv8vJ5pQ7K
         fYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXDBVb9DoiSymMWk0AFQK5uBRVXEjsO6eGZBfYrkcFM=;
        b=GExOsnnrjHVCuAQ9oxvguBBiTkWD8b8x8H9GyWz+3wkC380HgmoGcpXGZqYdUTX/ur
         gXF13jSvAEf7jyN+pbhtMR1OWrWYScPOPKhsUxYwN5P9TCJnC9misEQpgDNxQb/e/TrI
         cyeTjB5L1kzHynaVjmxifWMIWBtkmWDGebOQvCgg98LEtGNGAM/lF578cod82f3p+KJ3
         yTZYrnNvCGI75shzez/tue1tkMHGgWMwyKsHOZ+BZU5Rwf9ApIKtoegR42WtmCyZ/hZl
         nM1lyXy/1nesoFsSOaNi2ODDK6fFU1WqNbnleaTTn4L8N2ig3CWjoQw809boSM3YNhcV
         rqEA==
X-Gm-Message-State: ACgBeo0Gkjm5SS2YsxkyDf5PwX00SNcRbktJnRt9N4DPh1wpY0g7LNOL
        CDIFYA0BGL8aY9nkp8FPhFSDyMXgO+ADLzdLV+s=
X-Google-Smtp-Source: AA6agR4aLQ8BZBvlRBzXmVfIOWIn7FTf5WNR/w8LfsI6rJN7mxVK6yhk63TEJ5e+jrc4Fp5zcGMRT4HhQfHrqtaIiVY=
X-Received: by 2002:a05:6e02:1c23:b0:2dc:e497:8b12 with SMTP id
 m3-20020a056e021c2300b002dce4978b12mr1565787ilh.151.1659645112585; Thu, 04
 Aug 2022 13:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220802015052.10452-29-ojeda@kernel.org> <YukvvPOOu8uZl7+n@yadro.com>
In-Reply-To: <YukvvPOOu8uZl7+n@yadro.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 4 Aug 2022 22:31:41 +0200
Message-ID: <CANiq72m30zTwgSgV3+CDiMqdt2LH7TvkcnkMSw3B2do_gLn=Ng@mail.gmail.com>
Subject: Re: [PATCH v8 28/31] samples: add Rust examples
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     ojeda@kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 4:08 PM Konstantin Shelekhin
<k.shelekhin@yadro.com> wrote:
>
> A minor neat, but ain't it possible to use &str here in order to drop
> this ugly binary string prefix?

Yeah, we would like to remove those at some point -- please see
https://github.com/Rust-for-Linux/linux/issues/252.

Cheers,
Miguel
