Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE7ED537990
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 13:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiE3LHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 07:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbiE3LHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 07:07:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DE8DEF7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 04:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20B3CB80CEE
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 11:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60086C385B8;
        Mon, 30 May 2022 11:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653908824;
        bh=B9Xc66hOdAZOXo+Tc+BhGcJxCOagPi2WwOBzK74A6dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kt6JgfGYA2s+hgTzM7NQRYgRG5gRMbwrDyV2+zcyvx2lX+7vk4rVStUoRV3W5IVFN
         M7j9DuwCq5sbRqtNW+08JoOsiRS9j3PadA/fKMpPqy+AUZ/pegAb9oqIDellBysaJF
         PZEiEKXZTo/TQOeKz0uUES9CWyWGNEuzgvEGqzbfkv+fZB2QnMA3/VkyVtGEl4e8tI
         JrDr0vbBKekVzdS+NDRpSUX5/a4i6U5ac3okdE5FEW0x4MHpbmUQlfXN5E68YpHZdy
         vYLSAJ13U4FbYlNiTyKrMZZtjweLH8FGNe3MBf9eV4JUkZsarw4tIz05rDKTfI2/eW
         4LY9GJrdNbC6A==
Date:   Mon, 30 May 2022 13:07:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     paulmck@kernel.org, rjw@rjwysocki.net, x86@kernel.org,
        linux-kernel@vger.kernel.org, jpoimboe@kernel.org
Subject: Re: [RFC][PATCH 2/9] x86/idle: Replace x86_idle with a static_call
Message-ID: <20220530110701.GB1257179@lothringen>
References: <20220519212750.656413111@infradead.org>
 <20220519213421.687917982@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519213421.687917982@infradead.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 11:27:52PM +0200, Peter Zijlstra wrote:
> Typical boot time setup; no need to suffer an indirect call for that.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
