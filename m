Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4991A4E508D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243599AbiCWKnc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Mar 2022 06:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240536AbiCWKna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:43:30 -0400
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44DE96D1B4;
        Wed, 23 Mar 2022 03:42:00 -0700 (PDT)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9BA26CED32;
        Wed, 23 Mar 2022 11:41:53 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] Bluetooth: mt7921s: Fix the incorrect pointer check
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5d56b2a23e6e793c64ed98890329ce1beb010ce0.1647991506.git.objelf@gmail.com>
Date:   Wed, 23 Mar 2022 11:41:53 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yake Yang <yake.yang@mediatek.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <6F03EA00-35D0-4E43-A8BD-8A3618C87695@holtmann.org>
References: <5d56b2a23e6e793c64ed98890329ce1beb010ce0.1647991506.git.objelf@gmail.com>
To:     Sean Wang <sean.wang@mediatek.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Fix the incorrect pointer check on ven_data.
> 
> Fixes: f41b91fa1783 ("Bluetooth: mt7921s: Add .btmtk_get_codec_config_data")
> Co-developed-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Yake Yang <yake.yang@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> drivers/bluetooth/btmtksdio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

