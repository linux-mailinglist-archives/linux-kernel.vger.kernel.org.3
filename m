Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A264B7C46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbiBPBLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:11:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245410AbiBPBLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:11:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9612BF5426;
        Tue, 15 Feb 2022 17:11:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3512961741;
        Wed, 16 Feb 2022 01:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C56C340EB;
        Wed, 16 Feb 2022 01:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644973859;
        bh=IKAdFG1ScRZwrYF3lRBmxcqtvrVn4JWBCrJ3n+qCEio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L54brTvCDIuxdADxI8jBpQ/9q82/BimAIDjlCe9rJp+li96pSPYjyZPJ2hcPzpRfn
         /akbESPv5PLlI3x11bpCrORl0N1nvG7IrVLcmzTgc9ZZb/rvimGLwH/cM456pxaTz3
         oNxXK0pxuwBYkKW9RBuz9b9hx7uTIw2qvzktakQN5zSNgAGg3UehspxnoYf1ztIBSJ
         +0jo+NIGUq0xfOWWqc29lRgGjueyq3dplnv9Y0RFskNkyoIzP+mmwgi7+W2lR958gc
         XD9g1/TRbdAq3UbTlWWsso6l4GzkHlV6VrTQtld1VgQQRaNDyHlfgK3CGiNIro+Hn9
         7hrI76Wi6VBhA==
Date:   Tue, 15 Feb 2022 19:18:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] extcon: usbc-cros-ec: Use struct_size() helper in
 kzalloc()
Message-ID: <20220216011837.GA890303@embeddedor>
References: <CGME20220125192140epcas1p27d09a1d2ceaed49dd7c410c0223c51d7@epcas1p2.samsung.com>
 <20220125192634.GA70834@embeddedor>
 <3136d3aa-4c01-33be-86de-1a2b3b6b6733@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3136d3aa-4c01-33be-86de-1a2b3b6b6733@samsung.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:26:34AM +0900, Chanwoo Choi wrote:
> On 1/26/22 4:26 AM, Gustavo A. R. Silva wrote:
> 
> Applied it. Thanks.

Great. :)

Thanks, Chanwoo.
--
Gustavo
