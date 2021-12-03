Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12794467F31
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 22:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353858AbhLCVZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 16:25:14 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49180 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235538AbhLCVZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 16:25:13 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 59764CED20;
        Fri,  3 Dec 2021 22:21:47 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v2] Bluetooth: btmtksdio: enable AOSP extension for MT7921
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <662a29b7e66c7018b00fd84564831a2d78cef7d8.1638501745.git.objelf@gmail.com>
Date:   Fri, 3 Dec 2021 22:21:47 +0100
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
Message-Id: <6281040F-AEA9-4C2B-8B4B-D4094068B3EC@holtmann.org>
References: <662a29b7e66c7018b00fd84564831a2d78cef7d8.1638501745.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Similar to MT7921 btusb, we enable AOSP extension for MT7921 btmtksdio
> as well.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v2: rebase onto the top of "[v2] Bluetooth: btmtksdio: enable msft
> opcode"
> ---
> drivers/bluetooth/btmtksdio.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

