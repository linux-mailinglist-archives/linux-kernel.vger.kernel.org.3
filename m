Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0407589AB4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbiHDLAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiHDLAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:00:00 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AC813D05
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 03:59:58 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31f41584236so196783907b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mYh7Ouih07Y3JkD/4mGPnS2e5gIQyHSI8E3r8KOj1vc=;
        b=oUwjUKM8jcd/JaE0oM61547C6N9OXxl5+tpApKpWs3g4cD4FmPmzuXjFJCmlZSqtGT
         RVd0ZwA2ntr1g/bgWzJ5+TcCpjOnnFQW/HQtRSPEQfsIxKWFLM/JIrQqWZds5kgWvj2T
         GnyIAMHEM6N90RW9JSK2B5g0dz7u+ci4ZV/U0Uk0J5613kSXMvkwBnD+6RnRbUUvfO+/
         XaENnOTnBDXOqZxAnVtQXSvu76TKbBlNNKCrbZ+mm2m9ZbAY1RrSRdieHWw1k5ynAQT1
         puJC+VaImpXclR2yDkggDC6xQA/XawXFQGMKNEEw53p/zO61G213O+jA51nZLq2liTRD
         vAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mYh7Ouih07Y3JkD/4mGPnS2e5gIQyHSI8E3r8KOj1vc=;
        b=gp0qXYPP3V3kjEKZMe22ljJz7FQg4x2kf5bzTyFT7vLGUFsb9nqg6pUOkZ1jx6v7nk
         XX6g0o+4hbEYbfH+XwCmjmcpvKJc9NrTW2r9mHSJvGR2OYxlM7LzuFHHSeeB2xFfmvS7
         eqhSJCNFieO4z6a+vj1hB+ybVMM1ZRskhtbNiBWC+Em/wa0MJ+frLDw4jUD17zxVBeo1
         Fm1HV1TlpmcIYedJEwU4AXzSIQzsUEMTVZwwpcxs4xgaoM2+SuVy1Ca/KzQA3xrKIKRC
         edyIK4SAvG5OOIBlzRjc+VgatuhPW3OsjprRcPhUJhfplAMY0GzDS0B6rzkkb0NPp+PJ
         otyw==
X-Gm-Message-State: ACgBeo2ALyHIoV0vjoFjIoYQQLkZTalmDeHyBrRt7zKNzR7O0AQCRxih
        xz2Y9FtsX3ubjPUYUP+SSkqzUSoz35SkMqJJyiSPqA==
X-Google-Smtp-Source: AA6agR7lf5Dq9DgZgvvP2FPGckvJRR3LeclWaANwXGWpFM1rOqMiuHvwOGZ84pGNZvRCelokRf4Bk5BKMXgyOLIaVQk=
X-Received: by 2002:a81:b812:0:b0:328:68e4:c886 with SMTP id
 v18-20020a81b812000000b0032868e4c886mr1082057ywe.502.1659610797795; Thu, 04
 Aug 2022 03:59:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220714160951.9364-1-pdk@semihalf.com> <20220802154128.21175-1-pdk@semihalf.com>
 <YuuKu4b02siXj/TS@google.com>
In-Reply-To: <YuuKu4b02siXj/TS@google.com>
From:   Patryk Duda <pdk@semihalf.com>
Date:   Thu, 4 Aug 2022 12:59:42 +0200
Message-ID: <CAGOBvLpB2Xc5NDT_Ffq-_Bc-CRZQ6eAHV9ctSVkcOfqcCCc4Ag@mail.gmail.com>
Subject: Re: [PATCH v1] platform/chrome: cros_ec_proto: Update version on
 GET_NEXT_EVENT failure
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@google.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 4 sie 2022 o 11:00 Tzung-Bi Shih <tzungbi@kernel.org> napisa=C5=82(a)=
:
>
> On Tue, Aug 02, 2022 at 05:41:28PM +0200, Patryk Duda wrote:
> > Fixes: 3300fdd630d4 ("platform/chrome: cros_ec: handle MKBP more events=
 flag")
> > Cc: <stable@vger.kernel.org> # 5.10+
>
> Any concerns if removing the Cc tag?  As I think a Fixes tag should be
> sufficient.  On a related note, why did you specify for only 5.10+?
Submitting patches document mentions that 'Fixes:' helps stable kernel
team in determining which stable kernel versions should receive the fix.

However, there is a note:
"Attaching a Fixes: tag does not subvert the stable kernel rules process
nor the requirement to Cc: stable@vger.kernel.org on all stable patch
candidates."
https://www.kernel.org/doc/html/v5.19/process/submitting-patches.html#using=
-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Stable kernel versions older than 5.10 don't suffer from this issue.
>
>
> > Signed-off-by: Patryk Duda <pdk@semihalf.com>
>
> You should collect the Reviewed-by tags the patch already got as dropping
> `ver_mask` initialization isn't a big change.  I could do that for the pa=
tch
> this time.
Thank you!
>
> [...]
> > v0 -> v1
> > - Dropped `ver_mask` initialization.
>
> Please start versioning from v1 next time.
Ok, thanks!
