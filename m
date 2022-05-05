Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7947651BE04
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357259AbiEELdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355252AbiEELdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:33:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3734B413;
        Thu,  5 May 2022 04:29:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E6A2B82B7C;
        Thu,  5 May 2022 11:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C569EC385A8;
        Thu,  5 May 2022 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651750196;
        bh=fpHDNWEN7YzzDGEjiJGbxik1DUzH+e+TOMt6yTYjg9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jrb+15PGa5yVDSM07ay5ihUysNQCbFt3Ty3N9ZWtxEjBhpMCHFYoe8xGdVKbJ28qG
         L6LkDfadNCxgUm0C2Bsnc15HvuJg1tVuNeh1P9RxeOWu+VtRwk/sZBxmYNUGpqGfMc
         IzADgPG+TBeWDbDGqdiZHzVA5Z2erilp91q88SbQ8K8DONFUTQD8pRYAJPaIhS8MHk
         kkR44QpuUzSPRxVdh+P81lFKCkBkagqBzyqFxgJHZ3vGxv5w9Q+YKEoArEapE1Lisi
         wRJC3yGg8+ZHT3UxSi+xuYg9ZdOCN56VhehNxEZZvc18Go5jD1doUfnZzAPe6lUzW7
         aTXq3WaZlM9Iw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1nmZgC-0001rw-IX; Thu, 05 May 2022 13:29:57 +0200
Date:   Thu, 5 May 2022 13:29:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     ipis.yang@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gchiang@sierrawireless.com,
        Ethan Yang <etyang@sierrawireless.com>
Subject: Re: [PATCH v3] usb: serial: qcserial: add support for Sierra
 Wireless EM7590
Message-ID: <YnO1NHWCFCIfydBI@hovoldconsulting.com>
References: <YmYvPXeqQzyms91m@kroah.com>
 <20220425055840.5693-1-etyang@sierrawireless.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220425055840.5693-1-etyang@sierrawireless.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 01:58:40PM +0800, ipis.yang@gmail.com wrote:
> From: Ethan Yang <etyang@sierrawireless.com>
> 
> add support for Sierra Wireless EM7590 0xc080/0xc081 compositions
> 
> Signed-off-by: Ethan Yang <etyang@sierrawireless.com>
> ---

Please include a short changelog here (after the ---) when updating
patches.

Please also include the output of usb-devices (or lsusb -v) for these
two compositions for completeness.

Johan
