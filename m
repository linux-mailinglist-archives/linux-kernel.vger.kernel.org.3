Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E048517ABB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 01:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiEBXav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 19:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiEBXaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 19:30:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931972E68F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 16:26:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D70B86131B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 23:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123F8C385A4;
        Mon,  2 May 2022 23:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651533982;
        bh=8WHHzJ/+UvPJOCm81uQIw5ZgLSglmWRdhEoAYDNX08U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bk4xpdMTTrbk+e5J4l39nCYxr0BP4YqlCSsOPYB1QJwnO6d8nkyCCXb/7NFSzrER/
         wR2xQs3sfHJDGJQgFZSShFMk7C0vBOjuVJubjJ9J/E2gvNIWMsRER6HuW7GvFBh7hP
         LVNlauFgtF6LKE505897Qr1U3yL5CDIUqQ9vyZxY=
Date:   Tue, 3 May 2022 01:26:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, sboyd@kernel.org,
        rafael@kernel.org, johannes@sipsolutions.net, keescook@chromium.org
Subject: Re: [PATCH v4] devcoredump : Serialize devcd_del work
Message-ID: <YnBonb+4K12JIp+L@kroah.com>
References: <1651505671-1506-1-git-send-email-quic_mojha@quicinc.com>
 <a9d66a63-4a26-9051-1540-69cd0d1056ec@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d66a63-4a26-9051-1540-69cd0d1056ec@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 09:06:08PM +0530, Mukesh Ojha wrote:
> This should be v4, corrected in the subject

Please resend a new verison, with an updated version, our tools can't
handle responses like this and attempt to find the original commit.

Remember, be explicit, we deal with hundreds of patches a day...

thanks,

greg k-h
