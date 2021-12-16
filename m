Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0583477CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241157AbhLPT5G convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Dec 2021 14:57:06 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:33591 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhLPT5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:57:05 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id A628FCED18;
        Thu, 16 Dec 2021 20:57:03 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v3] Bluetooth: btqca: sequential validation
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1639570900-24509-1-git-send-email-quic_saluvala@quicinc.com>
Date:   Thu, 16 Dec 2021 20:57:03 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        quic_hemantg@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org,
        mcchou@chromium.org, quic_pharish@quicinc.com
Content-Transfer-Encoding: 8BIT
Message-Id: <5F7F1736-3B51-48DE-9DEF-89774353A85C@holtmann.org>
References: <1639570900-24509-1-git-send-email-quic_saluvala@quicinc.com>
To:     Sai Teja Aluvala <quic_saluvala@quicinc.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sai,

> Added Sequential validation support
> & patch command config
> 
> Signed-off-by: Sai Teja Aluvala <quic_saluvala@quicinc.com>
> 
> v3:
> * removed rlen,rtype
> * Replaced kfree with kfree_skb
> 
> v2:
> * Added static declaration
> * Addressed wrong indentation
> * Removed EDL_PATCH_CONFIG_CMD_LEN
> *
> 
> v1:
> *Initial patch
> ---
> drivers/bluetooth/btqca.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h |  2 ++
> 2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index be04d74..21830c6 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -141,6 +141,51 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
> 	return err;
> }
> 
> +static int qca_send_patch_config_cmd(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	int err = 0;
> +	u8 cmd[] = {EDL_PATCH_CONFIG_CMD, 0x01, 0, 0, 0};

I am going to stop looking at this patch now. You are not able to address review comments.

From now on, I am only going to review QCA patches from people that are able to handle review comments.

Regards

Marcel

