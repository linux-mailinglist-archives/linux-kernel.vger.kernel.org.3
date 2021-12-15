Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BF44756E4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241777AbhLOKum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:50:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46812 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236465AbhLOKul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:50:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3558F6189B;
        Wed, 15 Dec 2021 10:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C92C34605;
        Wed, 15 Dec 2021 10:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639565440;
        bh=fBDAdnwsiLYqTB9X9ZMV+lcS9zZiXaJtdDEeMKie1bI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JALhmVZZA2yWS1OqYGHDmcNryXTgYe+qHhrHkpdynoMRi0J/DdXUrUf+o9y3LuAhs
         RrryrG1/FQEBiOvDP6owZ+6ZqIZ5LqKF3RTq9WHrsup2jz2p69VABfY4SEkUGf6i+Q
         0oJ9zgnrCnxCj7nw+rwkAwsv+TjkNZrp0hQbKFbE=
Date:   Wed, 15 Dec 2021 11:50:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dejia Shang <dejia.shang@armchina.com>
Cc:     robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        toby.shang@armchina.com
Subject: Re: [PATCH 0/4] misc: add ArmChina Zhouyi NPU driver
Message-ID: <YbnIfr5UQfF+MgZH@kroah.com>
References: <20211215103609.9268-1-dejia.shang@armchina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215103609.9268-1-dejia.shang@armchina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 06:36:05PM +0800, Dejia Shang wrote:
> IMPORTANT NOTICE: The contents of this email and any attachments may be privileged and confidential. If you are not the intended recipient, please delete the email immediately. It is strictly prohibited to disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you. ©Arm Technology (China) Co., Ltd copyright and reserve all rights. 重要提示：本邮件（包括任何附件）可能含有专供明确的个人或目的使用的机密信息，并受法律保护。如果您并非该收件人，请立即删除此邮件。严禁通过任何渠道，以任何目的，向任何人披露、储存或复制邮件信息或者据此采取任何行动。感谢您的配合。 ©安谋科技（中国）有限公司 版权所有并保留一切权利。

Now deleted.
