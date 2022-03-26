Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434F54E7E30
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiCZAfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 20:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCZAfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:35:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBE121DF30;
        Fri, 25 Mar 2022 17:33:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C588617B3;
        Sat, 26 Mar 2022 00:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0F2C2BBE4;
        Sat, 26 Mar 2022 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648254815;
        bh=w4U5kORHPWzESZWMPu8Su6601eZFODqaEtPPUNEQETI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3k/NVBMdqHUwVIlRZKyAnbSvLKZoRkPsrqfgYE09d+vVSYh+RbKnG7pvJBKYFmu9
         UOTKIXetYVQ1dnUvfCZYCahQW1DcwAKT/i8nopsTT3HnyN8iQc1avBLcvU9Xhixa59
         +PJg06pb8mrc+u7lJemCCLyt6K/oZ+yK9Wn+6nx8t9T2p9/I3JUSJizgHp/AaLPANB
         AtTjmMkLbiK8BlQhpx1DE811lA3jDaGqqYYZXjENjDLPk29Yiloi0Gs2zWYopiveGy
         iy2J+H0HS2bShKbvViQUmTjzMOBbi25GaOiOMPh0xPLe3DlcMJP1U1TkR3UnnyjJHd
         lQqIE0v90W78A==
Date:   Fri, 25 Mar 2022 19:42:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH] uapi: wireless: Replace zero-length array with
 flexible-array member
Message-ID: <20220326004244.GC2602091@embeddedor>
References: <20220216195306.GA904220@embeddedor>
 <202202161235.C593433C94@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202202161235.C593433C94@keescook>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 12:36:27PM -0800, Kees Cook wrote:
> On Wed, Feb 16, 2022 at 01:53:06PM -0600, Gustavo A. R. Silva wrote:
> > There is a regular need in the kernel to provide a way to declare
> > having a dynamically sized set of trailing elements in a structure.
> > Kernel code should always use “flexible array members”[1] for these
> > cases. The older style of one-element or zero-length arrays should
> > no longer be used[2].
> > 
> > [1] https://en.wikipedia.org/wiki/Flexible_array_member
> > [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
> > 
> > Link: https://github.com/KSPP/linux/issues/78
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> This UAPI change should be fine for any compiler that understood the
> older "[0]" syntax.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Hi all,

Friendly ping: can someone take this, please?

...I can take this in my -next tree in the meantime.

Thanks
--
Gustavo
