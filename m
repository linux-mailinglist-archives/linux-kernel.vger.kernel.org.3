Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C8C57EEB5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238873AbiGWK0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239039AbiGWK0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:26:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9CB78DC8;
        Sat, 23 Jul 2022 03:18:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b26so9535075wrc.2;
        Sat, 23 Jul 2022 03:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2PsGZSWn0bfvtONY6PDPYrkHIwoL8aynVvc2kGa9teo=;
        b=UBW7PtNXbdPbsimJC+KyVkiUt/Nz+2BDq1KjUxOcLO0OqWIhYuTY9MVgTs4C1PwgbJ
         IhQSL67p6NBuf78XSZ3W9LnJ7UDSutE2aOqfzVtZ8T2LDMsTfDsjZPLLIp5ec2aH7NFp
         9r5pbkEnwS7BYBw43OMwZtJZn13b+mIjWg3qznMIA/ZvhqjxkgFY+a8kidt5I8T2QfRa
         /ykUXrFCPgt3dSeCQmDLhcDH0crvirS44sD03He55SYlL6VlgILxCH/yH1TeE5qarVuN
         Vn1MPOd61KYArMf0/LzwW+LUs2hS8D1jC5WpnZ3Br8zoZRXwAVgFl32YCQptti6sZ0nP
         qmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2PsGZSWn0bfvtONY6PDPYrkHIwoL8aynVvc2kGa9teo=;
        b=0pCjehYu6TqrzImnlv9SYv0NghDD0KGvbnzV4cuFI2kawLIHdtW/jHQYIIcerpwvD3
         KwL8sgfJtGRB06xPC1gU4OQ6lpiQ7yQYMyxJWvJ1TdXIuoneM/FQLmtL/Pp2yjyNzfq4
         chFAN7/+uGds5tgjsssJbSbE9vASaZJCGmuGtesf7ZmBhpSzpmHL/aijUWMWaG2jgmP6
         +no0bGZmUzsOPdMZlqKE1JIgAdY5nxSAGvovW0pS9l2ZSmKkI2M4QKNuU8I7w/msENYe
         g8LPIGRgq7W3otcydKDKf1BVpb1WYXwUgLkICcmS73CdaNiPz3iIKCFdfPH0lj5BhcXa
         qiBQ==
X-Gm-Message-State: AJIora9SWh7A5diXzzDN6lNgMwT/rsSsBHvg234Y95I+UuSpxxDRESfs
        zzamaPy5Zh1phxBi5q8sS14=
X-Google-Smtp-Source: AGRyM1unTp8g5WHUUH5FU/LcH6liCfcE0kUzkRIkE4yWBS0MVpzyd9Hfh9FMn9D0WeSYwh6MnzysLg==
X-Received: by 2002:a05:6000:1f0b:b0:21d:6dae:7d04 with SMTP id bv11-20020a0560001f0b00b0021d6dae7d04mr2496059wrb.414.1658571530047;
        Sat, 23 Jul 2022 03:18:50 -0700 (PDT)
Received: from reki (62-44-238.netrun.cytanet.com.cy. [62.228.44.238])
        by smtp.gmail.com with ESMTPSA id q5-20020a1ce905000000b003a0323463absm7849803wmc.45.2022.07.23.03.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 03:18:49 -0700 (PDT)
Date:   Sat, 23 Jul 2022 13:18:47 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-next@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, sfr@canb.auug.org.au
Subject: Re: [PATCH v2] docs: fixed table margin in
 configfs-usb-gadget-mass-storage
Message-ID: <20220723131847.131a92b5@reki>
In-Reply-To: <YtvAJGY2jleLodgt@kroah.com>
References: <20220723074054.54995-1-mdevaev@gmail.com>
        <YtvAJGY2jleLodgt@kroah.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Sat, 23 Jul 2022 11:32:20 +0200
Greg KH <gregkh@linuxfoundation.org> =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> On Sat, Jul 23, 2022 at 10:40:54AM +0300, Maxim Devaev wrote:
> > Fixes: 421c8d9a20da ("usb: gadget: f_mass_storage: forced_eject attribu=
te")
> > Signed-off-by: Maxim Devaev <mdevaev@gmail.com>
> > ---
> >  v1 -> v2: Added Greg KH to CC so that he can accept this into his bran=
ch =20
>=20
> For obvious reasons, I can not take a change without any changelog text
> at all, and neither should any other maintainer.
>=20
> Also you forgot the reported-by line :(
>=20
> thanks,
>=20
> greg k-h

Thank you for your patience. V3 sent.
