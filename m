Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53765A3225
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 00:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345356AbiHZWmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 18:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344902AbiHZWmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 18:42:01 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2547582757
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:42:00 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id g16so2227593qkl.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3FV8KCi0eK0OYqVvKJ/bGBoHBlxMg4pZUjZlSa7NDhE=;
        b=QPn/UljNvn1jh6/KTyMRkKx3YkKr7mR07kzA4/Uwjsic96qUrmuGVvSmreCQVtiPNF
         UYtUGIM5xK9pvqccmR9OBaz9WfFMiZcwf6jJkc1xixXKE6L5PDWxs4PKjk6f4vEok/MK
         /OTfi7Ru+2eiHTjqEN2nGHyJ9w7brJKYrGiAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3FV8KCi0eK0OYqVvKJ/bGBoHBlxMg4pZUjZlSa7NDhE=;
        b=kS40Om0khOupzJdUpBzbgSki7xB5l1/VTM3KOFNksdNLnRx8HgQYP27+ScUsVw8Bvn
         3xAr018hVjKbtdZ/pp0FvsmkMdrEovuVD7s0gbx7BtdgOOlZNnpyz4h45NGuywWKeNNv
         V6DxxkfY8N9bjPHhyYIiF2vNMrkVD3HncIzPKuHU9mgsO59PQsZAo89A0caLgwXyUU8F
         pdgAlRpoI0kTnkMuPmCKifTz4itCaKfyma9ITKLzIS9y4mTNlYD7GquEfnHxVG+6XnjI
         lsBDP2aVSsExUvDZe69WmIUwOqoUthz0f58BAt1abrK+zVijoNuZ6Mm12chNEMbB6F1b
         k6xA==
X-Gm-Message-State: ACgBeo3FTjY/vjfAK0u7KqBz5ut1NpUj4kQTFtDpvnym1FzuTf877YHN
        529l7QX9em44kbohr47oLt3TmVDEego1OhiZYx9t5Zh3Gzg=
X-Google-Smtp-Source: AA6agR5mUHqmoyjkSgGYnIHALwXRxS29qzcU5DuHX7qeu+4HF4ozsmDfcUVUcwjy6pmq4mphYEUSaYXvQRxbi45sk1c=
X-Received: by 2002:a05:620a:4553:b0:6bb:1dd0:e44c with SMTP id
 u19-20020a05620a455300b006bb1dd0e44cmr1288845qkp.543.1661553719348; Fri, 26
 Aug 2022 15:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190807.1275937-1-pmalani@chromium.org> <166155361559.15250.6333484675187018145.git-patchwork-notify@kernel.org>
In-Reply-To: <166155361559.15250.6333484675187018145.git-patchwork-notify@kernel.org>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Fri, 26 Aug 2022 15:41:48 -0700
Message-ID: <CACeCKacPZNLYA-OwMohNQzo-NpqoM6WXz73dcAJJ11h4wLJqcA@mail.gmail.com>
Subject: Re: [PATCH 0/4] platform/chrome: cros_ec_typec: Altmode fixes
To:     patchwork-bot+chrome-platform@kernel.org
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, heikki.krogerus@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 3:40 PM
<patchwork-bot+chrome-platform@kernel.org> wrote:
>
> Hello:
>
> This series was applied to chrome-platform/linux.git (for-kernelci)
> by Prashant Malani <pmalani@chromium.org>:
>
> On Fri, 19 Aug 2022 19:08:01 +0000 you wrote:
> > This is a short series of minor fixes and changes to prepare the
> > ChromeOS Type-C driver to better support alternate mode drivers.
> >
> > Prashant Malani (4):
> >   platform/chrome: cros_ec_typec: Add bit offset for DP VDO
> >   platform/chrome: cros_ec_typec: Correct alt mode index
> >   platform/chrome: cros_ec_typec: Stash port driver info
> >   platform/chrome: cros_ec_typec: Use Type-C driver data
> >
> > [...]
>
> Here is the summary with links:
>   - [1/4] platform/chrome: cros_ec_typec: Add bit offset for DP VDO
>     https://git.kernel.org/chrome-platform/c/1903adae0464
>   - [2/4] platform/chrome: cros_ec_typec: Correct alt mode index
>     https://git.kernel.org/chrome-platform/c/4e477663e396
>   - [3/4] platform/chrome: cros_ec_typec: Stash port driver info
>     (no matching commit)
>   - [4/4] platform/chrome: cros_ec_typec: Use Type-C driver data
>     (no matching commit)

This message isn't completely right; I've only applied patches 1 and 2
( 3 and 4 will be resubmitted as part of the altmode support series
later).
