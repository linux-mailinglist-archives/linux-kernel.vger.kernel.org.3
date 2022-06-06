Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5253E73B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbiFFPSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240390AbiFFPSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:18:22 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF6100525
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:18:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x17so20308834wrg.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yeGsWUwpCqkjWUw73ezm6VojJaHFvekgLNZVHSqo7Vk=;
        b=jqOsThaHylCTCcwoOhLVg1XFb7HupBei3AqE6zAsnr53Rae0pt2I2ft8PAiQF+RDFx
         NG5eYCW+hMRDYDdAuHthvtZvb+0Sy+zkSuSlhXI4eSZpgaD5yydw5TJsK/tSdPu6UWxo
         WWscIeUsxEbkTc4uZrJff3xTeMtdYil/Z7z7WaOX2UxGcdjMqmiPw5KUw4CT86bAo7nM
         B4LDnMM9XcHtOIhVh9oXtZjgJeOP9/GxkUaNVRVa+c1QHaT/q+FqHE4jNsYcrh+tfYVy
         yI/yS+NENKjrVtLoLtJDuUcgqEHar/jklU4sVotrx8dmq/SGSyC13Um2p+YmYeXhx0/X
         1Dzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yeGsWUwpCqkjWUw73ezm6VojJaHFvekgLNZVHSqo7Vk=;
        b=WNfPFWUJfuGwdShlyNgBj4G/Rfld+Jiqx3bcCsZdPRi4xJJeJDXKJi7aX8HBoQAj/y
         Tpm4JFlKaYzqgmLa5W8k0NbciwL/p2pC5C3AV3YLiMEKJ7PUkLTzI5Eb/ZrOEiYWk5Yb
         NGaxHqQbjKo2INgLwVxENylRl4nyibAVOMpxWBco/W8d84dNK7SksdpaTv7c4XL33JZP
         PFcz94tFPuW4pmnEmSQ/eFpw0X76mdHojBeERDh7IXdXM7MN7ReUY5c9RhjMs29p2q59
         TIv8Em1bGZmrHdL2M+cq+kpys2gyFsDOvnzqezG8bnAsXNkVpo+5zjNw9W0yHp1I6Zkl
         3KMQ==
X-Gm-Message-State: AOAM531GTRiapoEr7B73jBw26mPhM/4sPIjBwsI4v4E60mNYrP8Lt2In
        PZaFgNBWQnVDIwNvyucIMkw=
X-Google-Smtp-Source: ABdhPJyfdynbUbRFVUwiSWF+FSgpV5zzbCJhjuM4ntSDGcaz4MbSpwgejdAwe7ix3NmvKNWH6FhDRQ==
X-Received: by 2002:adf:9bcd:0:b0:210:2fdc:c1f8 with SMTP id e13-20020adf9bcd000000b002102fdcc1f8mr21761855wrc.148.1654528699553;
        Mon, 06 Jun 2022 08:18:19 -0700 (PDT)
Received: from opensuse.localnet (host-79-13-108-3.retail.telecomitalia.it. [79.13.108.3])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d6711000000b00218453adaefsm1640899wru.101.2022.06.06.08.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:18:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH] staging: Also remove the Unisys visorbus.h
Date:   Mon, 06 Jun 2022 17:18:17 +0200
Message-ID: <5574984.DvuYhMxLoT@opensuse>
In-Reply-To: <20220606132200.2873243-1-pbrobinson@gmail.com>
References: <20220606132200.2873243-1-pbrobinson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 6 giugno 2022 15:22:00 CEST Peter Robinson wrote:
> The commit that removed the Unisys s-Par and visorbus drivers
> left around the include/linux/visorbus.h file mentioned in the
> MAINTAINERS entry, we can also remove that too.
>=20
> Fixes: e5f45b011e4a ("staging: Remove the drivers for the Unisys s-Par")
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>  include/linux/visorbus.h | 344 ---------------------------------------
>  1 file changed, 344 deletions(-)
>  delete mode 100644 include/linux/visorbus.h
>=20
Good catch, I had overlooked this file.

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

=46abio


