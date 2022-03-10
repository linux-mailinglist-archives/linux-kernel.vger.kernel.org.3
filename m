Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD74D4C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245499AbiCJO5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245436AbiCJOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:52:40 -0500
X-Greylist: delayed 2014 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 06:51:08 PST
Received: from www.kot-begemot.co.uk (ivanoab7.miniserver.com [37.128.132.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9711C6818;
        Thu, 10 Mar 2022 06:51:08 -0800 (PST)
Received: from [192.168.18.6] (helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1nSJbW-0006Ue-Os; Thu, 10 Mar 2022 14:17:26 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1nSJbT-004kxK-Pc; Thu, 10 Mar 2022 14:17:21 +0000
Subject: Re: [PATCH] docs: UML: Mention telnetd for port channel
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     kernel@axis.com, linux-um@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220310124230.3069354-1-vincent.whitchurch@axis.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <e1709d07-6217-90b9-273a-50b32798da55@cambridgegreys.com>
Date:   Thu, 10 Mar 2022 14:17:19 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220310124230.3069354-1-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/03/2022 12:42, Vincent Whitchurch wrote:
> It is not obvious from the documentation that using the "port" channel
> for the console requires telnetd to be installed (see port_connection()
> in arch/um/drivers/port_user.c).  Mention this, and the fact that UML
> will not boot until a client connects.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index 2cafd3c3c6cb..d5ad96c795f6 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -664,7 +664,11 @@ one is input, the second one output.
>   * The fd channel - use file descriptor numbers for input/output. Example:
>     ``con1=fd:0,fd:1.``
>   
> -* The port channel - listen on TCP port number. Example: ``con1=port:4321``
> +* The port channel - start a telnet server on TCP port number. Example:
> +  ``con1=port:4321``.  The host must have /usr/sbin/in.telnetd (usually part of
> +  a telnetd package) and the port-helper from the UML utilities (see the
> +  information for the xterm channel below).  UML will not boot until a client
> +  connects.
>   
>   * The pty and pts channels - use system pty/pts.
>   
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
