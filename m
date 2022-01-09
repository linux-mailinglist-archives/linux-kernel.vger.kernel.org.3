Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB87488C0F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 20:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbiAITgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 14:36:48 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:53543 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiAITgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 14:36:46 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id 31AC5CED27;
        Sun,  9 Jan 2022 20:36:44 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v5 1/5] Bluetooth: btmtksdio: rename btsdio_mtk_reg_read
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <a22b710e69551c3503203f73ea898504cb634815.1641755121.git.objelf@gmail.com>
Date:   Sun, 9 Jan 2022 20:36:43 +0100
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
        Michael Sun <michaelfsun@google.com>,
        Miao-chen Chou <mcchou@chromium.org>, shawnku@google.com,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <39A8FEA2-D5AA-4D3D-9A14-E9EC187D300A@holtmann.org>
References: <a22b710e69551c3503203f73ea898504cb634815.1641755121.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Using "btmtksdio" as the prefix instead of "btsdio"
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v5: new created to make the series better
> ---
> drivers/bluetooth/btmtksdio.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

