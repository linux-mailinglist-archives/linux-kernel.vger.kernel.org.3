Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775D64ED453
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 09:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiCaHDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 03:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiCaHCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 03:02:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2C1EF5C0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:01:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w21so27731007wra.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 00:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kSVb1dTbWdbne8U6VvmE51Q2krf82Epq6ExE1DUNwlY=;
        b=DWwExqt6wOKpB5leH0YrszfY4BBOcAmwKWK3k3xC8z8e3PXmH2PV8rw7gkliIKYfYT
         YGcBgvBEmCwLigZ8CW8xgyRn+gx82i8csj/m8AzVx9MonCoVLLvo8bCJwMzEiS496oft
         GvpunYLmNbKAs8mZL4KSAxIJZvc/3srBuPY+/2Q8kOIolZ91IWFOg0Bq8qSPL6AmJKTo
         W/TBtzfmNxYjQAvzlw8mEEc4phADplW4qxzOFr7V6DxqNobma2+MH61VJSbUqzMNGEGV
         B048JowqMWFaHg0uup350luMdndFk+UtyJxvESamR7b0WLTDnWkc5Cy9tfFc+ovLDIcN
         NZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kSVb1dTbWdbne8U6VvmE51Q2krf82Epq6ExE1DUNwlY=;
        b=f9WjYUOXt/DqKl8k/bz7d5ipSpuU/LuLtV/4JCBU5068zbVNkwW+MrBjIgv6Qm5/51
         wP6+sUv9zyxxdhCjHF2W4qVChFY4Nz9n456j8NT1X8jZrpooDenglDKCVdbedk508/Ca
         DF5wmgPOXq4rzIXgwIyD5ZsmE9g3+bfDXsDhJLhV2j8hwRLac9y9VXCEDZLFj0vepVr/
         jHcTQcJ+ZeTepdeu6f7p9PIni+VrS10GMjLmcPjNTPbGlEea1U/wU5ca6zbI9mmeM3zF
         /INp9he1vYMhjVqQaR4sb8qdRnFnLR54hNHBG36dt2Bk9uDrqPGPeiWZXHOQcAhWlqOt
         f6UA==
X-Gm-Message-State: AOAM530aIg65/DvaafdMsFwCWNHaycbBZjf0+pmPBHi8f7quc9bPj9Yg
        gEoSh6ESXKLgFWNKFTQ752I=
X-Google-Smtp-Source: ABdhPJyVQ+8U4h+ZzHr7EWX8iqE5z6jQcrTABOrQQenrmyRHHZPiTBRsumyMbVJb1jBTKWKM7T0Y2A==
X-Received: by 2002:adf:f102:0:b0:205:7d05:d250 with SMTP id r2-20020adff102000000b002057d05d250mr2943236wro.350.1648710063300;
        Thu, 31 Mar 2022 00:01:03 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c1c0f00b0038cabc63721sm6875058wms.30.2022.03.31.00.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 00:01:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        sparmaintainer@unisys.com
Cc:     David Kershner <david.kershner@unisys.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] staging: unisys: Remove "struct dentry *eth_debugfs_dir"
Date:   Thu, 31 Mar 2022 09:00:59 +0200
Message-ID: <2098282.irdbgypaU6@leap>
In-Reply-To: <20220331064751.29634-1-fmdefrancesco@gmail.com>
References: <20220331064751.29634-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 31 marzo 2022 08:47:51 CEST Fabio M. De Francesco wrote:
> There is no need for "struct dentry *eth_debugfs_dir" which is used for
> debug / sysfs directories. Therefore, remove this "struct dentry" and
> everything related (i.e., creation and removal).
>=20
> As a side effect of this change, the code has no more need of the
> "cleanup_register_netdev" label, which can also be removed.
>=20
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>=20
> v1 - v2: Add a couple of "Suggested-by" tags which were forgotten.=20
> Thanks to Dan Carpenter and Greg Kroah-Hartman.
>=20
>  drivers/staging/unisys/visornic/visornic_main.c | 17 -----------------
>  1 file changed, 17 deletions(-)

As said some days ago, the email address of David Kershner at unisys.com
is not anymore reachable. Each time I submit patches for this Unisys'=20
driver I get the following message:

Delivery has failed to these recipients or groups:

David Kershner (david.kershner at unisys.com)
The email address you entered couldn't be found.=20
Please check the recipient's email address and try to resend the message.

Is it the case to remove his entry from the MAINTAINERS file? I'm asking
because I don't yet know how these kinds of issues are handled.=20

Any suggestions?

Thanks,

=46abio M. De Francesco



