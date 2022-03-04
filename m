Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB94CD7D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbiCDPcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238996AbiCDPc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:32:28 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64E9D1C57E6;
        Fri,  4 Mar 2022 07:31:40 -0800 (PST)
Received: from smtpclient.apple (p5b3d2910.dip0.t-ipconnect.de [91.61.41.16])
        by mail.holtmann.org (Postfix) with ESMTPSA id AEE81CECCA;
        Fri,  4 Mar 2022 16:31:39 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH] Bluetooth: move adv_instance_cnt read within the device
 lock
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <f181dc17-3b27-436b-15c1-832feb573d25@ugent.be>
Date:   Fri, 4 Mar 2022 16:31:39 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6F62ECEB-DBCD-434B-BA9A-CF7942B8AD55@holtmann.org>
References: <f181dc17-3b27-436b-15c1-832feb573d25@ugent.be>
To:     Niels Dossche <niels.dossche@ugent.be>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niels,

> The field adv_instance_cnt is always accessed within a device lock,
> except in the function add_advertising. A concurrent remove of an
> advertisement with adding another one could result in the if check
> "if a new instance was actually added" to not trigger, resulting
> in not triggering the "advertising added event".
> 
> Signed-off-by: Niels Dossche <niels.dossche@ugent.be>
> ---
> net/bluetooth/mgmt.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

