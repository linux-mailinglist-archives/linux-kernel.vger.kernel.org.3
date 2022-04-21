Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4654E50A5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiDUQaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbiDUQ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:29:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5537496A2;
        Thu, 21 Apr 2022 09:25:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D463CE2494;
        Thu, 21 Apr 2022 16:25:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456EEC385A8;
        Thu, 21 Apr 2022 16:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650558319;
        bh=ddOFzdwyWEU5fXNj9entLJBfZ/tMOaoRtM0a4lmBROg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YOytt1UiwcZnyfxDJQ+vVffCAxDjI6NjeqNxkTHyrCTwafe20LfwRP37L+Z255rNt
         j/cogu0thwFrNmplpvrAVm/D9BG9ILic6NgGPHGvkB3MY7Pjsbfg6VRjEA4AuFLb3J
         rlwFJ+5qPynq6qeViQuQqvshXMhaCkaZEvyK1eac=
Date:   Thu, 21 Apr 2022 18:25:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: typec: rt1719: Fix build error without
 CONFIG_POWER_SUPPLY
Message-ID: <YmGFbLdUOUTb1Y1q@kroah.com>
References: <20220418082425.41566-1-renzhijie2@huawei.com>
 <90205fce-05aa-c8d5-4e39-9529194723aa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <90205fce-05aa-c8d5-4e39-9529194723aa@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 08:46:39AM +0800, Ren Zhijie wrote:
> ping...
> 
> 在 2022/4/18 16:24, Ren Zhijie 写道:

It was posted 3 days prior, relax please.

If you are eager to see patches reviewed faster, please help out and
review them on the lists, we can always use the help.

thanks,

greg k-h
