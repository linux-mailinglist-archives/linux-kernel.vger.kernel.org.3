Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8160646C81E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242521AbhLGXVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:21:23 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46670 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhLGXVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:21:19 -0500
Received: from thelio.attlocal.net (107-203-255-60.lightspeed.sntcca.sbcglobal.net [107.203.255.60])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8EE6320B7179;
        Tue,  7 Dec 2021 15:17:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8EE6320B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638919068;
        bh=+AgCPfzGq0vzf6r769uhi87f9O0oNq+MOFu54QgQj8g=;
        h=From:To:Cc:Subject:Date:From;
        b=r5LZCYwRXco0p/q2+rfixaCvaDcCFy+4MSAZvp9XVWN1ej5LjrMP7wijZHlNplSOA
         TZfEdEGYqwHvQ9FxKJW0t+6WAoMTYbDJt9gYMDVBzYhbu9qhT6sQJ68hg9Roq6tbV6
         7JVpV4BBBErTP2UF0PUufIiC1Vzj2eBq62u4FKNY=
From:   Katherine Perez <kaperez@linux.microsoft.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] arm64: qcom: sm8350-duo2: enable battery charger
Date:   Tue,  7 Dec 2021 15:17:35 -0800
Message-Id: <20211207231736.1762503-1-kaperez@linux.microsoft.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the battery charger for Microsoft Surface Duo 2.

Katherine Perez (1):
  arm64: dts: qcom: sm8350-duo2: enable battery charger

 .../boot/dts/qcom/sm8350-microsoft-surface-duo2.dts  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--
2.31.1

