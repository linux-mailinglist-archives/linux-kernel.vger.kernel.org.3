Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1387A4873E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:08:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbiAGIIl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 7 Jan 2022 03:08:41 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:52346 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235551AbiAGIIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:08:40 -0500
Received: from smtpclient.apple (p4fefca45.dip0.t-ipconnect.de [79.239.202.69])
        by mail.holtmann.org (Postfix) with ESMTPSA id DEC8ACECE8;
        Fri,  7 Jan 2022 09:08:36 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v5] Bluetooth: btqca: sequential validation
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1641536453-7628-1-git-send-email-quic_saluvala@quicinc.com>
Date:   Fri, 7 Jan 2022 09:08:36 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        quic_hemantg@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_bgodavar@quicinc.com, rjliao@codeaurora.org,
        hbandi@codeaurora.org, abhishekpandit@chromium.org,
        mcchou@chromium.org
Content-Transfer-Encoding: 8BIT
Message-Id: <597B76E1-F88B-49C6-B849-5D9835AF3A06@holtmann.org>
References: <1641536453-7628-1-git-send-email-quic_saluvala@quicinc.com>
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
> v5:
> * Addressed spacing in cmd
> * Addressed position of int err declaration
> * Removed redundant debug message
> 
> v4:
> * addressed the change from u8 cmd to const u8 cmd
> 
> v3:
> * removed rlen,rtype
> * Replaced kfree with kfree_skb
> 
> v2:
> * Added static declaration
> * Addressed wrong indentation
> * Removed EDL_PATCH_CONFIG_CMD_LEN
> 
> v1:
> *Initial patch
> ---
> drivers/bluetooth/btqca.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
> drivers/bluetooth/btqca.h |  2 ++
> 2 files changed, 48 insertions(+)

so I applied this patch to bluetooth-next tree after fixing up the commit message.

However, this is the last patch from anyone of your team that I am taking. The disrespect of the patch submission guidelines or even basic attempt to submit a patch in the correct form or with comments addressed is astonishing. Please read up on patch submission guidelines or watch Greg KH's multiple talks on the topic. You are wasting my time and there is no reason that simple patches like this take 7-10 attempts to get it right.

If you want to know what you did wrong this time around, then maybe try to “git am” your email to a clean bluetooth-next and look on how it looks like with “git show” afterwards before sending it to anybody.

Regards

Marcel

