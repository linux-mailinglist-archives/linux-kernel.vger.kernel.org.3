Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E384E468E9D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:39:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhLFBmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:42:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33050 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhLFBmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:42:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EED761167;
        Mon,  6 Dec 2021 01:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9BC2C341C6;
        Mon,  6 Dec 2021 01:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638754755;
        bh=KMliAwKX/niuka2mBX7iVAAmZw49RiAIcGEdn/Ci3uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYLt4Mhg4oXQTP5s07seiT7qg+k87j/0UrYTTzvXC7OTg9gKYQMSHEcro8w7RrrYg
         HQfwuUV4mWjXrjGu/oxPtmLeD5QpZK37cfJDAp689+zYosNlkdDvN8NL/pYY0Gojf6
         fvnoeVicrWg1HUs7N7uNqOyGqoeYKS6YMN+HIqdhcxtMFFwUx31vdfUNu9HJd4QEw0
         QPpRBQcpxCebQms/j1QjgRCDmB8hSa94fmmdNmt+a8wXQBOr0M6nSWMb3Rx83c54se
         SYqARo4m0eYZvi8kEPBaj4GDqiE6rYbVmXeT60lI/TkQrSLAkEsb8xRd16lEImh0hZ
         3dExla1I7jXFA==
Date:   Mon, 6 Dec 2021 09:39:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Kuldeep Singh <kuldeep.singh@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH] arm64: dts: lx2162a: Add CAN nodes for LX2162A-QDS
Message-ID: <20211206013910.GQ4216@dragon>
References: <20211124090214.1475159-1-kuldeep.singh@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124090214.1475159-1-kuldeep.singh@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 02:32:14PM +0530, Kuldeep Singh wrote:
> Enable CAN support for LX2162A-QDS in board dts.
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>

Applied, thanks!
