Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865604BA0A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240694AbiBQNHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:07:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238898AbiBQNHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:07:38 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E71D1EA72D;
        Thu, 17 Feb 2022 05:07:24 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id C8101CECDE;
        Thu, 17 Feb 2022 14:07:22 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2 2/2] Bluetooth: mediatek: fix the conflict between mtk
 and msft vendor event
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5f5f1e801432af9318bc604c54a6c15dcd8ab036.1644342794.git.objelf@gmail.com>
Date:   Thu, 17 Feb 2022 14:07:22 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        =?utf-8?B?Ik1hcmstWVcgQ2hlbiAo6Zmz5o+a5paHKSI=?= 
        <Mark-YW.Chen@mediatek.com>, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <075A0FD1-8145-43E0-A4C2-13AF0436C08C@holtmann.org>
References: <d328920a9abaaaedafc8c4922cdeb5935f6d64c3.1644342794.git.objelf@gmail.com>
 <5f5f1e801432af9318bc604c54a6c15dcd8ab036.1644342794.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> There is a conflict between MediaTek wmt event and msft vendor extension
> logic in the core layer since 145373cb1b1f ("Bluetooth: Add framework for
> Microsoft vendor extension") was introduced because we changed the type of
> mediatek wmt event to the type of msft vendor event in the driver.
> 
> But the purpose we reported mediatek event to the core layer is for the
> diagnostic purpose with that we are able to see the full packet trace via
> monitoring socket with btmon. Thus, it is harmless we keep the original
> type of mediatek vendor event here to avoid breaking the msft extension
> function especially they can be supported by Mediatek chipset like MT7921
> , MT7922 devices and future devices.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v2: fix the warning: variable 'hdr' set but not used
> ---
> drivers/bluetooth/btmtk.h     | 1 +
> drivers/bluetooth/btmtksdio.c | 9 +--------
> drivers/bluetooth/btusb.c     | 8 --------
> 3 files changed, 2 insertions(+), 16 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

