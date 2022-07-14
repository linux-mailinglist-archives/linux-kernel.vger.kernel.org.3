Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAC0575082
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiGNOM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbiGNOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:12:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA355142D;
        Thu, 14 Jul 2022 07:12:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58B24B823DD;
        Thu, 14 Jul 2022 14:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C95FC3411C;
        Thu, 14 Jul 2022 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657807944;
        bh=NdP/Cebxr5aJuKwhxDJtHQ5Exp0F5QGsMJPUMUIRnG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PBnRtcmmjTVFLkkcjUAf+USm50Bm6dCxYsmMZ+U2Qfa1gjW0kV7VT8+qh9dFrxluS
         o1IXQnxSmzN/d93p9qk+AiEHq8myO9MKE2Db8eNMYHkEmMEsKCJdArqzHcQrGjAhoZ
         0WRIwzpExkORG5C7fTrcRyO5ezyw59iIlbWgCtIU=
Date:   Thu, 14 Jul 2022 16:09:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Strachuk <strochuk@ispras.ru>
Cc:     Bin Liu <b-liu@ti.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] usb: musb: remove useless condition from
 musb_gadget_dequeue()
Message-ID: <YtAjfxg+hU7kscd7@kroah.com>
References: <20220711151736.17382-1-strochuk@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711151736.17382-1-strochuk@ispras.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 06:17:36PM +0300, Andrey Strachuk wrote:
> Comparison of 'ep' with NULL is useless since
> 'ep' is a result of container_of and cannot be NULL
> in any reasonable scenario.

Again, show the call stack as this is not called with container_of()
here.

thanks,

greg k-h
