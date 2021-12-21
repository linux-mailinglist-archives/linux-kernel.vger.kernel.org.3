Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540D647C1A5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 15:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbhLUOiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 09:38:21 -0500
Received: from mail-m17643.qiye.163.com ([59.111.176.43]:28718 "EHLO
        mail-m17643.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhLUOiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 09:38:20 -0500
DKIM-Signature: a=rsa-sha256;
        b=ZOTauHFSTptQElpXZ96+6MkHnw7m/374FVSmeXCjCQE9QFDsXeobqVeRvr3ThhrQVf38metm8RmuzBFHpDGO/Db1WXxHhcltqxwKom5hHUfmYsm5YKGa6bX+2MmrWZQCXtPHVxEj0/jJMUWpvv9/DhbhzEbltu1WLUemJSUXwQs=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=qqi2NB++O8YsRSISzGbQPm9lkvKN4dVoNjxQD2PLFW8=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-600-G6.vivo.xyz (unknown [58.251.74.232])
        by mail-m17643.qiye.163.com (Hmail) with ESMTPA id 76B457E03B1;
        Tue, 21 Dec 2021 22:38:18 +0800 (CST)
From:   Yaqin Pan <akingchen@vivo.com>
To:     s.shtylyov@omp.ru
Cc:     akingchen@vivo.com, balbi@kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel@vivo.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: document snps,dis_split_quirk property in dwc3
Date:   Tue, 21 Dec 2021 22:38:06 +0800
Message-Id: <20211221143806.4143-1-akingchen@vivo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cb1c928c-07fa-e6f0-8166-d68596224105@omp.ru>
References: <cb1c928c-07fa-e6f0-8166-d68596224105@omp.ru>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWUJMTE1WT09MTR0eH0xDHk
        1LVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OjI6HSo4LT5WPSgcPBoxPjVK
        Eh0aCjhVSlVKTU9LS0JMT0JCS0lMVTMWGhIXVRoQEhUcGBMeFTsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSElZV1kIAVlBSklISTcG
X-HM-Tid: 0a7ddd6dc681d999kuws76b457e03b1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, i make a mistake, and the snps,dis_split_quirk should be snps,sprs-ctrl-trans-quirk.
And i will renew the patch.
