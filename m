Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E38F4ECEA0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347513AbiC3VRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 17:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347216AbiC3VQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 17:16:57 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE6C57B04
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:15:10 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u26so25919946eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 14:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pWAvixEuLhuCRYGbQpWsXrGh9fg4phORRc02pDgp+O0=;
        b=SFfOhwfezqFjJhpRD+zpZbMHbYbCIq16B58Fesz9fkpuiDehn2XXdASrPgcItIRMbI
         iZig+jFeHUr5KVZBPo5La/E/ZoZ09hxPUOsEVWa2YL1qdidsEJDek4p6PE/M00DTjGg2
         fhgWoQkJweZoZbtM7KWQZUaOqK8MeoNqtYI6Al1amHz/u/CYOvlyzJJrEoC65U+nfB4K
         O4KoDYPCaR2RsEH/n3aAYJOsV3jtFLqVmKVwfRrUUq6lb7KDwrte9dyL68FHodMoyIoN
         jHBB4OZJ3V+52BTOHvPQMysdkr9IicoTi2v4cXlvvOZivcOCBaPqeG/n94lnzg+FAc5u
         S1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pWAvixEuLhuCRYGbQpWsXrGh9fg4phORRc02pDgp+O0=;
        b=pj+XKMBu3ysCKHRa/aU53vvR+Dn1x72rOASewA0xfj4WwVSSB5IOMxspYQtXdqcPHn
         M1tAmB7BwGMqwn2dlmFGXUr4jH41M0Twsjt8Kw6FU6Y6fO/dyakRQX+BlqgwqeTfeBSp
         SjNrZ62GYV+7Uy9oM8/GPvTz9k2RTVMP6zn+OVRLHgT26qBXlc7QM0u/ldlYlQt+KBej
         3nuAP5p6vvdjceEOU52IvYy/77YjKbgBc9klTyK8Cz4G4OYKtIiE47DsC5HNx5LImIeR
         sYJbujxK78IvV1ejUXfy2rGYVmnVOVWM7VrRfi1eupnpfiI0zll7wNsM1+J+oVIzxDXF
         iEQw==
X-Gm-Message-State: AOAM532VheVG5ShxsJMBCjUdJwSjn+DDskeLawjQp0yr6rN8YgxLK1/3
        jIdgk9GcnK7Zjy99VoipiR+AvIjyA8JxB9zoIqSeNQ==
X-Google-Smtp-Source: ABdhPJy3rMIZvcEKbv/17lOxmRiaoLHd4Sh2G4bBrWY53xs7Vn+nk3fKJzCHIv0bOML5js66Nn+fybGvPAW9Rr7x2LE=
X-Received: by 2002:aa7:d6ca:0:b0:419:2804:d094 with SMTP id
 x10-20020aa7d6ca000000b004192804d094mr13224533edr.388.1648674909251; Wed, 30
 Mar 2022 14:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220330204809.2061497-1-wonchung@google.com>
In-Reply-To: <20220330204809.2061497-1-wonchung@google.com>
From:   Won Chung <wonchung@google.com>
Date:   Wed, 30 Mar 2022 14:14:57 -0700
Message-ID: <CAOvb9yhPKe8tHWewSzYR1+HyZZNM_4SfOq53DXgGViMa9HM6yA@mail.gmail.com>
Subject: Re: [PATCH v2] misc/mei: Add NULL check to component match callback functions
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@google.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 1:48 PM Won Chung <wonchung@google.com> wrote:
>
> Component match callback functions need to check if expected data is
> passed to them. Without this check, it can cause a NULL pointer
> dereference when another driver registers a component before i915
> drivers have their component master fully bind.
>
> Fixes: 1e8d19d9b0dfc ("mei: hdcp: bind only with i915 on the same PCH")
> Fixes: c2004ce99ed73 ("mei: pxp: export pavp client to me client bus")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Won Chung <wonchung@google.com>
> ---
> Changes from v1:
> - Add "Fixes" tag
> - Send to stable@vger.kernel.org
>
>  drivers/misc/mei/hdcp/mei_hdcp.c | 2 +-
>  drivers/misc/mei/pxp/mei_pxp.c   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/mei/hdcp/mei_hdcp.c b/drivers/misc/mei/hdcp/mei_hdcp.c
> index ec2a4fce8581..843dbc2b21b1 100644
> --- a/drivers/misc/mei/hdcp/mei_hdcp.c
> +++ b/drivers/misc/mei/hdcp/mei_hdcp.c
> @@ -784,7 +784,7 @@ static int mei_hdcp_component_match(struct device *dev, int subcomponent,
>  {
>         struct device *base = data;
>
> -       if (strcmp(dev->driver->name, "i915") ||
> +       if (!base || !dev->driver || strcmp(dev->driver->name, "i915") ||
>             subcomponent != I915_COMPONENT_HDCP)
>                 return 0;
>
> diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
> index f7380d387bab..e32a81da8af6 100644
> --- a/drivers/misc/mei/pxp/mei_pxp.c
> +++ b/drivers/misc/mei/pxp/mei_pxp.c
> @@ -131,7 +131,7 @@ static int mei_pxp_component_match(struct device *dev, int subcomponent,
>  {
>         struct device *base = data;
>
> -       if (strcmp(dev->driver->name, "i915") ||
> +       if (!base || !dev->driver || strcmp(dev->driver->name, "i915") ||
>             subcomponent != I915_COMPONENT_PXP)
>                 return 0;
>
> --
> 2.35.1.1021.g381101b075-goog
>

Hi,

I am resending this patch to correct email account.
Sorry for confusion.

Thanks,
Won
