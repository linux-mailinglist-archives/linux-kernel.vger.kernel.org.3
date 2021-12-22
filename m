Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4AF47D90F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 23:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbhLVWCw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 17:02:52 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:49058 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhLVWCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 17:02:50 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9030FCED16;
        Wed, 22 Dec 2021 23:02:46 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v4] arm64: dts: qcom: sc7280: Add bluetooth node on SC7280
 IDP boards
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <YcNVRNqAbfAYpCWH@ripper>
Date:   Wed, 22 Dec 2021 23:02:46 +0100
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        Rocky Liao <rjliao@codeaurora.org>, hbandi@codeaurora.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        mcchou@chromium.org, saluvala@codeaurora.org
Content-Transfer-Encoding: 8BIT
Message-Id: <A24CF0E8-AA9A-48B8-AE50-74F86F600825@holtmann.org>
References: <1639587963-22503-1-git-send-email-bgodavar@codeaurora.org>
 <580E8974-EB7F-4493-BECC-4B09765A954D@holtmann.org>
 <YcNOvlVQaT80qPsx@google.com> <YcNVRNqAbfAYpCWH@ripper>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

>>>> Add bluetooth SoC WCN6750 node for SC7280 IDP boards.
>>>> 
>>>> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
>>>> ---
>>>> v4:
>>>> * updated commit subject
>>>> * Removed drive strength for bt_en
>>>> * updated swctrl_gpio name to sw_ctrl
>>>> 
>>>> v3:
>>>> * Addressed reviewers comments
>>>> * Added pin config for sw_ctrl line.
>>>> v2:
>>>> * merged two patches into one
>>>> * Removed unused comments
>>>> * Removed pinmux & pin conf.
>>>> * Addressed reviewers comments
>>>> 
>>>> v1: initial patch
>>>> ---
>>>> arch/arm64/boot/dts/qcom/sc7280-idp.dts  |  4 ++++
>>>> arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 36 ++++++++++++++++++++++++++++++++
>>>> arch/arm64/boot/dts/qcom/sc7280-idp2.dts |  4 ++++
>>>> 3 files changed, 44 insertions(+)
>>> 
>>> patch has been applied to bluetooth-next tree.
>> 
>> Thanks!
>> 
>> I would have expected though that a device tree change goes through
>> the qcom tree. Maybe Bjorn should pick it too to avoid possible
>> conflicts?
> 
> That would be preferable, I've picked a few patches in these files for
> v5.17, so there's a risk for conflict as this reaches Linus.
> 
> Marcel, let me know if you drop this and I should pick it up.

ok, dropped the patch.

Regards

Marcel

