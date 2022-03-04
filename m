Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FC4CDA2B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiCDRWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiCDRWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:22:32 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38DC6151365;
        Fri,  4 Mar 2022 09:21:44 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6AA68CECCE;
        Fri,  4 Mar 2022 18:21:43 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_bcm: add BCM43430A0 & BCM43430A1
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220225204138.935022-2-luca@z3ntu.xyz>
Date:   Fri, 4 Mar 2022 18:21:43 +0100
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7574788C-E8CC-4386-A714-48E5712E6A92@holtmann.org>
References: <20220225204138.935022-1-luca@z3ntu.xyz>
 <20220225204138.935022-2-luca@z3ntu.xyz>
To:     Luca Weiss <luca@z3ntu.xyz>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

> Add the compatible for BCM43430A0 bluetooth used in lg-lenok and
> BCM43430A1 used in asus-sparrow.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes in v2:
> - add bcm43430a1 too, adjust commit message to reflect that
> 
> drivers/bluetooth/hci_bcm.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

