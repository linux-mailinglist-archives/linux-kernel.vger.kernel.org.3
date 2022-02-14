Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703A94B5306
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbiBNOQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:16:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbiBNOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:16:29 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E87DDC3A;
        Mon, 14 Feb 2022 06:16:19 -0800 (PST)
Received: from smtpclient.apple (p4fefcd07.dip0.t-ipconnect.de [79.239.205.7])
        by mail.holtmann.org (Postfix) with ESMTPSA id 13AE3CED30;
        Mon, 14 Feb 2022 15:16:19 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v4] Bluetooth: btusb: Improve stability for QCA devices
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1644835419-23943-1-git-send-email-zijuhu@codeaurora.org>
Date:   Mon, 14 Feb 2022 15:16:18 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        MSM <linux-arm-msm@vger.kernel.org>, c-hbandi@codeaurora.org,
        Hemantg <hemantg@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, tjiang@codeaurora.org,
        Zijun Hu <quic_zijuhu@quicinc.com>
Content-Transfer-Encoding: 7bit
Message-Id: <20772D11-FD65-4123-A538-3230278A506F@holtmann.org>
References: <1644835419-23943-1-git-send-email-zijuhu@codeaurora.org>
To:     Zijun Hu <zijuhu@codeaurora.org>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zijun,

> WCN6855 2.1 will reset to apply firmware downloaded, so wait
> a moment for reset done then go ahead to improve stability.
> 
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
> drivers/bluetooth/btusb.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

