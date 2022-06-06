Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EAA53EBDA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbiFFQWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241781AbiFFQW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:22:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8F118394;
        Mon,  6 Jun 2022 09:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96EF4B81AA1;
        Mon,  6 Jun 2022 16:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2A2C385A9;
        Mon,  6 Jun 2022 16:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654532544;
        bh=j7IUs7yRQCl8j/106T+umARMA3D4ZiDhm3+saSv/in8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M0dG5VfTla8EYYJ33PkcKgful1cNhhE4GzRQzxLJ+9aOQ4xXuDtR0TV8ygmZogkbo
         c995Cgl4j2VkKtEmInIYeiIo3g9qYwSjwibn+uFvpf36QCoeWXDEptU45dvoGU74mc
         pZ7HoG4r6t7WooZclPadbjsRntccDgrhGzfxwG0Jzm1wgr7iJPyvrOi8GOkXpFMkTd
         U+h28RR2D8tGaX9MSQq577BmcNCnDp699tVrCsYpKFuj2/OUe5dRXommAD35+gTYnR
         32BmLkGxmi7s/eynDwAqiouB7ckHAZkcMSGFdOu8m75A/7qTPr612TAvf3ChoguJ6V
         xW1VjxmMjcyoQ==
Date:   Mon, 6 Jun 2022 09:22:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/23] docs: netdev: update maintainer-netdev.rst
 reference
Message-ID: <20220606092220.6a474d7b@kernel.org>
In-Reply-To: <ee0778cb0ae9c26047277610d52e8e3c70b4cf5e.1654529011.git.mchehab@kernel.org>
References: <cover.1654529011.git.mchehab@kernel.org>
        <ee0778cb0ae9c26047277610d52e8e3c70b4cf5e.1654529011.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Jun 2022 16:25:29 +0100 Mauro Carvalho Chehab wrote:
> Changeset 8df0136376dc ("docs: netdev: move the netdev-FAQ to the process pages")
> renamed: Documentation/networking/netdev-FAQ.rst
> to: Documentation/process/maintainer-netdev.rst.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 8df0136376dc ("docs: netdev: move the netdev-FAQ to the process pages")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Acked-by: Jakub Kicinski <kuba@kernel.org>
