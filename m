Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254CC58F477
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiHJWjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiHJWjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:39:44 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355201EED3;
        Wed, 10 Aug 2022 15:39:43 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id l5so5922016qtv.4;
        Wed, 10 Aug 2022 15:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=QZBTYi+VEK64R94iNXEvHjwZ/0qToFyQap9z+Hhq+d0=;
        b=WH/EwXAl2LmAbi3hf7nRLyiW1waDVehKdqOnwKH1m6D4Ce+kZsBn7lrcmaoROyt/Eh
         77aBdD7slF07/5BrhjDgJKVN6HEUhEJOhWtrcqft6ikgCvkU+GCuhUOzoOdfgfS78pbH
         KqseMb/sMXD+YyhoFNqcJiAX8nKFy/vSaTlGyyibOBzd2VtD/0zQ1MaxCHlmB2sHEbx9
         OWjhv8DtszxlDwwO16eKW78+dD2FoL70/zXWOo4fDgzDzWerLdNje+g5omb9birfFkkP
         OtH8EGiESbGTvvhGCygaZUZvdxoo7xDSg5ecd6PtWOA2MbLteo4hyhk+u49zk1HL/ibh
         9RPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=QZBTYi+VEK64R94iNXEvHjwZ/0qToFyQap9z+Hhq+d0=;
        b=tv0dJoBRygK+z8jpsgy79115il1a/1oSJE5thmB/tLpu3gu56MtxKBQoIfLfM+LAJV
         REMSDXyW8N2zkTzPFCJYEIycLXxDan6+NHCNl6nqaxNU2afBncUvSHaXfi4EIX3OMMIN
         oOzde7ccND8Pwno+QRxz87R/HhauK9TGMwv/eDox0LpzvB9J9Tv60/NSxiPJ0om1j4RW
         vO2QNPmrN7wYtQjjX2D2QCEmojOHMbgMXy0WmU92gofeaWb5h53txHWX3fWcR3/JQDiB
         CM8YDgxmSkoCKVz4uOZpSJRZ8brXJ2YeCBXIZw3im0mkRc6FqqD8QYAGdm9yf1aGIjDw
         8e4g==
X-Gm-Message-State: ACgBeo3ydGh2FoEmAXPjbS6d5wPHVTIvYs3D1Yeza3ICjadGyuLQm3U7
        PDuCFm8dki91+5eZNIVMkOKL6Tdf9lM=
X-Google-Smtp-Source: AA6agR6K+rdz4l3oQRcNmwUqVhY9cIB4FwxeZTNriI5uboQJkkwAT8CAjv3nqZvhi8o0nRHmGXxZOQ==
X-Received: by 2002:ac8:5a83:0:b0:343:11f:a781 with SMTP id c3-20020ac85a83000000b00343011fa781mr12039898qtc.19.1660171182287;
        Wed, 10 Aug 2022 15:39:42 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6-20020ac84e86000000b0033a5048464fsm781592qtp.11.2022.08.10.15.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 15:39:41 -0700 (PDT)
Message-ID: <ced3ecce-ab5c-2d89-32ec-3d5eba654fff@gmail.com>
Date:   Wed, 10 Aug 2022 15:39:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] usb: host: xhci-plat: suspend/resume clks for brcm
Content-Language: en-US
To:     justinpopo6@gmail.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1660170455-15781-1-git-send-email-justinpopo6@gmail.com>
 <1660170455-15781-3-git-send-email-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1660170455-15781-3-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/22 15:27, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> The xhci_plat_brcm xhci block can enter suspend with clock disabled to save
> power and re-enable them on resume. Make use of the XHCI_SUSPEND_RESUME_CLKS
> quirk to do so.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
