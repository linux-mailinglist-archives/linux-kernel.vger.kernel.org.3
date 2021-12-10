Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7132C470408
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242965AbhLJPnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:43:01 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:55917 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbhLJPnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:43:00 -0500
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 61431240008;
        Fri, 10 Dec 2021 15:39:21 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     boris.brezillon@collabora.com,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        npitre@baylibre.com
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] i3c/master: Fix a potentially infinite loop in 'hci_dat_v1_get_index()'
Date:   Fri, 10 Dec 2021 16:39:20 +0100
Message-Id: <163915075349.211901.7503592107826023565.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <0cdf3cb10293ead1acd271fdb8a70369c298c082.1637186628.git.christophe.jaillet@wanadoo.fr>
References: <0cdf3cb10293ead1acd271fdb8a70369c298c082.1637186628.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2021 23:05:23 +0100, Christophe JAILLET wrote:
> The code in 'hci_dat_v1_get_index()' really looks like a hand coded version
> of 'for_each_set_bit()', except that a +1 is missing when searching for the
> next set bit.
> 
> This really looks odd and it seems that it will loop until 'dat_w0_read()'
> returns the expected result.
> 
> [...]

Applied, thanks!

[1/1] i3c/master: Fix a potentially infinite loop in 'hci_dat_v1_get_index()'
      commit: 3f43926f271287fb1744c9ac9ae1122497f2b0c2

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
