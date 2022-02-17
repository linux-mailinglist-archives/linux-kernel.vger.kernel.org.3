Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111424BA0A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240703AbiBQNIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:08:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239467AbiBQNIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:08:06 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2E89293B60;
        Thu, 17 Feb 2022 05:07:52 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id A1828CECDE;
        Thu, 17 Feb 2022 14:07:51 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2 1/2] Bluetooth: mt7921s: support bluetooth reset
 mechanism
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <d328920a9abaaaedafc8c4922cdeb5935f6d64c3.1644342794.git.objelf@gmail.com>
Date:   Thu, 17 Feb 2022 14:07:51 +0100
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
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chih-Ying Chiang <chih-yin.chiang@mediatek.com>
Content-Transfer-Encoding: 7bit
Message-Id: <EEA04207-812F-48F2-A2EC-2D6DD990F5D7@holtmann.org>
References: <d328920a9abaaaedafc8c4922cdeb5935f6d64c3.1644342794.git.objelf@gmail.com>
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

> Implement .cmd_timeout to reset the MT7921s device via a dedicated GPIO
> pin when the firmware hang or the command has no response.
> 
> Co-developed-by: Mark Chen <mark-yw.chen@mediatek.com>
> Signed-off-by: Mark Chen <mark-yw.chen@mediatek.com>
> Co-developed-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Chih-Ying Chiang <chih-yin.chiang@mediatek.com>
> ---
> v2: no change
> ---
> drivers/bluetooth/btmtk.h     |   6 ++
> drivers/bluetooth/btmtksdio.c | 113 +++++++++++++++++++++++++++++++++-
> 2 files changed, 118 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

