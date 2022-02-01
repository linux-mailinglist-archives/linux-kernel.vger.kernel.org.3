Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D714A5A67
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 11:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbiBAKoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 05:44:19 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:40170 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiBAKoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 05:44:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38221CE17DF;
        Tue,  1 Feb 2022 10:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD32C340EC;
        Tue,  1 Feb 2022 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643712247;
        bh=SIMjmziUWcpbFkWXO7CyZMzPR2P0hvql51eASbOkzis=;
        h=From:To:Cc:Subject:Date:From;
        b=B5fIHLJYWzWQBmVfNMUozPR8fvhTFnIa9of6gN1Mb8cKZp9fzFNmeBFMnh7Uardll
         tbivBn7W4RAmhH/TOgcfUxwUg2YsLvV+LRx1yn6omsRwQuEHHNMiCCD4O4VnPdM9qq
         6/L/AdVgLvstke9fX1E7oWxz8sw8lp7HdRv4VjFpPVVXA0WR2K5MvZW7Khhl5j7B+e
         JbSv9k2qINnNd9W5m1CdiX2K0cqtuItF2R4qf0211iobAPWhA0BOYTZwjT4OaNrO+J
         OY9wRsKSXtgE0Y0DsYpIwlB6yDdgL7e7fZkDDNsghkGsrmNvbjcWLeOSg0zoy+Bl5G
         AV6NsCjhSAxQw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nEqdb-0002hQ-Fw; Tue, 01 Feb 2022 11:43:51 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     "Russell, Scott" <Scott.Russell2@ncr.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] USB: serial: cp210x: add device ids for NCR products
Date:   Tue,  1 Feb 2022 11:42:51 +0100
Message-Id: <20220201104253.10345-1-johan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a couple of new ids to the cp210x driver for devices
found in various NCR products.

Johan


Johan Hovold (2):
  USB: serial: cp210x: add NCR Retail IO box id
  USB: serial: cp210x: add CPI Bulk Coin Recycler id

 drivers/usb/serial/cp210x.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1

