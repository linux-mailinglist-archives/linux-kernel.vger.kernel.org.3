Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4C554781E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 03:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiFLBJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 21:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiFLBJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 21:09:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8FB6A40B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 18:09:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CFF2B80B3C
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 01:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F52FC34116;
        Sun, 12 Jun 2022 01:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654996179;
        bh=+vrHBOuXBSxLKfRzhPeCOZ8kylNV/pL+ub6jHqdtBfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2hG4cGLN/cBckqDwwXt3+6A30alcEJYIU113UKkifTlQvUARdUsstQzIz9zPVVu9
         6GLsDMi6T/D5wsZodgxlVWHB6GqKMdICH5z1kMkCM7Q/vK5ZiZvX+DZXPPaLAnh04q
         0TUKFzrRjvh29tT2AUK/k0zkjMfi/NA5nfP0yjF3zjWKoMms4ANOdwfy7QX9A8nKE6
         4FOw7/zoi2CONMb6tC4rDxiEPoCZyamMLB40KOZdv6/ZMK6Oq7GcwDtLFdnV2oyfyE
         S3ArwAKgXxnXMbgcieRzej7SQTwjcLmX/2k2AAeSF1pCRkzT25XhI1oZGpl8WIeqwB
         2JDQZIohLYDaw==
Date:   Sun, 12 Jun 2022 09:09:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH RESEND] ARM: imx: Kconfig: Fix indentation
Message-ID: <20220612010933.GN254723@dragon>
References: <20220523062252.9710-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523062252.9710-1-juergh@canonical.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 08:22:52AM +0200, Juerg Haefliger wrote:
> The convention for indentation seems to be a single tab. Help text is
> further indented by an additional two whitespaces. Fix the lines that
> violate these rules.
> 
> While at it, replace separator tabs with whitespaces.
> 
> Signed-off-by: Juerg Haefliger <juergh@canonical.com>

Applied, thanks!
