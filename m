Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825EE46A5D4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348633AbhLFToE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Dec 2021 14:44:04 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56369 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243032AbhLFToC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:44:02 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id ACE26CECF9;
        Mon,  6 Dec 2021 20:40:32 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v3 2/2] Bluetooth: btusb: Return error code when getting
 patch status failed
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211206173343.31380-2-mark-yw.chen@mediatek.com>
Date:   Mon, 6 Dec 2021 20:40:32 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, sean.wang@mediatek.com,
        aaron.hou@mediatek.com, kaichuan.hsieh@canonical.com,
        pmenzel@molgen.mpg.de, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <B19A9F73-E925-4E69-81FB-51C135FD95EB@holtmann.org>
References: <20211206173343.31380-1-mark-yw.chen@mediatek.com>
 <20211206173343.31380-2-mark-yw.chen@mediatek.com>
To:     mark-yw.chen@mediatek.com
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> If there are failure cases in getting patch status, it should return the
> error code (-EIO).
> 
> Fixes: fc342c4dc4087 ("Bluetooth: btusb: Add protocol support for MediaTek MT7921U USB devices")
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btmtk.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

