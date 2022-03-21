Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5634E2747
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 14:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347775AbiCUNNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347768AbiCUNNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96FA56204;
        Mon, 21 Mar 2022 06:12:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B33961187;
        Mon, 21 Mar 2022 13:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7831AC340E8;
        Mon, 21 Mar 2022 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647868336;
        bh=Kb8tCvStzi3n8+JN0EGg2+VHaHWyv6cqBFtYcHbhL00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b82nQt1DCCW9qSMH3kxM4r3MZdwdv0P9PtsfuQmAGSjAf24WlF3qK5q78KVhVzEBu
         5a+8/KwI06gWqg0v0XOPj2vagC9oDBWUqnoAJ48leIx+R8gRL30lf2YC+IMOLjsNa2
         AihMafAa3tDmfNYajv0ABZ0owZZhiFHdAlid//7k=
Date:   Mon, 21 Mar 2022 14:12:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     sec@valis.email, steffen.klassert@secunet.com,
        tadeusz.struk@linaro.org, stable-commits@vger.kernel.org
Subject: Re: Patch "esp: Fix possible buffer overflow in ESP transformation"
 has been added to the 4.19-stable tree
Message-ID: <Yjh5rcxI/VW40j1+@kroah.com>
References: <16478662281158@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16478662281158@kroah.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 01:37:08PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     esp: Fix possible buffer overflow in ESP transformation
> 
> to the 4.19-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      esp-fix-possible-buffer-overflow-in-esp-transformation.patch
> and it can be found in the queue-4.19 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Oops, nope, sorry this breaks the build on 5.4 and older kernels, now
dropped.

greg k-h
