Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F565750EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiGNOf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiGNOf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:35:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2473DFEA;
        Thu, 14 Jul 2022 07:35:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FCE161D71;
        Thu, 14 Jul 2022 14:35:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2D10C341C6;
        Thu, 14 Jul 2022 14:35:54 +0000 (UTC)
Date:   Thu, 14 Jul 2022 10:35:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 08/13 v2] USB: mtu3: tracing: Use the new __vstring()
 helper
Message-ID: <20220714103553.553d9dc1@gandalf.local.home>
In-Reply-To: <YtAd7DUt2V4vYrYm@kroah.com>
References: <20220705224453.120955146@goodmis.org>
        <20220705224750.354926535@goodmis.org>
        <20220714093857.1135e95a@gandalf.local.home>
        <YtAd7DUt2V4vYrYm@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 15:45:16 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> > Changes since v1: remove ',' that fails the build.  
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks Greg!

-- Steve
