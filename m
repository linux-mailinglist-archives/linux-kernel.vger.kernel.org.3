Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A075047CE55
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 09:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhLVIdW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 03:33:22 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:36813 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhLVIdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 03:33:21 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 14FA5CED09;
        Wed, 22 Dec 2021 09:33:20 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v4] Bluetooth: hci_qca: Stop IBS timer during BT OFF
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1640158145-24569-1-git-send-email-quic_pharish@quicinc.com>
Date:   Wed, 22 Dec 2021 09:33:19 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        quic_hemantg@quicinc.com, MSM <linux-arm-msm@vger.kernel.org>,
        quic_bgodavar@quicinc.com, Rocky Liao <rjliao@codeaurora.org>,
        hbandi@codeaurora.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>, quic_saluvala@quicinc.com
Content-Transfer-Encoding: 8BIT
Message-Id: <0B5EAE00-967E-4D53-AC3E-B0182BFB8F80@holtmann.org>
References: <1640158145-24569-1-git-send-email-quic_pharish@quicinc.com>
To:     Panicker Harish <quic_pharish@quicinc.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Panicker,

> The IBS timers are not stopped properly once BT OFF is triggered.
> we could see IBS commands being sent along with version command,
> so stopped IBS timers while Bluetooth is off.
> 
> Fixes: 3e4be65eb82c ("Bluetooth: hci_qca: Add poweroff support during hci down for wcn3990")
> 
> Signed-off-by: Panicker Harish <quic_pharish@quicinc.com>
> ----
> v4:
>  * Used del_timer_sync() instead of mod_timer() to stop the timer and
>    to make sure the handler has finished executing on other CPUs.
> 
> v3:
>  *Addressed reviewers comments
>  *updated commit message
> 
> v2:
>  * Addressed the username
>  * The full implementation of IBS is based on timers
>    to that reason we have used timers.
> 
> v1: initial patch
> ---
> drivers/bluetooth/hci_qca.c | 3 +++
> 1 file changed, 3 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

