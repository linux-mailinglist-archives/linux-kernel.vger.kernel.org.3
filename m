Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD14D4413
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiCJJ6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiCJJ6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:58:02 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A672513C9FD;
        Thu, 10 Mar 2022 01:56:59 -0800 (PST)
Received: from smtpclient.apple (p5b3d2183.dip0.t-ipconnect.de [91.61.33.131])
        by mail.holtmann.org (Postfix) with ESMTPSA id 91A7CCECD8;
        Thu, 10 Mar 2022 10:56:58 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [PATCH v4 1/2] Bluetooth: hci_sync: Add a new quirk to skip
 HCI_FLT_CLEAR_ALL
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220307200445.5554-1-swyterzone@gmail.com>
Date:   Thu, 10 Mar 2022 10:56:58 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, pmenzel@molgen.mpg.de
Content-Transfer-Encoding: 7bit
Message-Id: <A006B33C-0A4C-4B68-B1DB-42BB8A1667D4@holtmann.org>
References: <20220307200445.5554-1-swyterzone@gmail.com>
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ismael,

> Some controllers have problems with being sent a command to clear
> all filtering. While the HCI code does not unconditionally
> send a clear-all anymore at BR/EDR setup (after the state machine
> refactor), there might be more ways of hitting these codepaths
> in the future as the kernel develops.
> 
> Cc: stable@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> ---
> include/net/bluetooth/hci.h | 10 ++++++++++
> net/bluetooth/hci_sync.c    | 16 ++++++++++++++++
> 2 files changed, 26 insertions(+)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

