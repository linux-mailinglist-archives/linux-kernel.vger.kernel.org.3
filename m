Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA30847B075
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhLTPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:38:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39882 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbhLTPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:38:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC956611F2;
        Mon, 20 Dec 2021 15:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA2FC36AE8;
        Mon, 20 Dec 2021 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640014720;
        bh=jZvynrgI+mxHpvVo0uaXVLOSajCtjusjJQ30p1o6rAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c0R3MBQJsWmThAFc34m5Ge23P+ocG1gjNawN98lNlawF4MCecQILD8vMBnDbOb8vd
         gnGkGTJ/lTYaZgN1SrnL8nE8QUqGuwf0Md5KTdhU42JIJ84HYgw8FWBDIX7ThFDkjd
         qOSUzOTmBEpXDB7d1M23LgDgQVv4OGSgRdI3S7qk=
Date:   Mon, 20 Dec 2021 16:38:37 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "xianwei.zhao" <xianwei.zhao@amlogic.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH] dt-bindings: serial: amlogic, meson-uart: support S4
Message-ID: <YcCjfZzH4j0w0r4c@kroah.com>
References: <20211210065239.21687-1-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210065239.21687-1-xianwei.zhao@amlogic.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 02:52:39PM +0800, xianwei.zhao wrote:
> Add serial bindings support menson S4 SoC family.
> 
> Signed-off-by: xianwei.zhao <xianwei.zhao@amlogic.com>

Please use your real name.  I doubt you sign documents with a "." in
your name :(

