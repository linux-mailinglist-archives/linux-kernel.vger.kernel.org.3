Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A29584B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiG2GXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiG2GXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:23:14 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630907AC03
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:23:13 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z22so4626645edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=jn7iNHkpfjyvOcSRY1FS0eqnb8a81QxEYqDJzIKy0rg=;
        b=VnPVkgWWYibvER1O6NFyX1pqmFaNRfiduYlMrdDL1OA04YSkzsNvhrM0c9oU3+bmWG
         Oybps67yGl7FcLItPA+I+EtUyu599cgHgTh4burV1ONC3JZFmQfzLfc+Tr5gh0PNzUiD
         9JafgKi+EtG4hRfb+N5Oq70Mb1bm5MreZ6lujTqkOFBkeZTchQ5xQVS2aBtgcbgKuR1/
         Fawhi0MMrmDNxyMFye1m5Cns3+gk2Ae5e1jZmnrtk4v/bwt0hAtQtRGvDjgNXjN8c1My
         TS8VewslcFTbjXkbhaHx8r5behOxYjTHqP10GEx+806xHYyqm7DLGKPBWVzGCHyy19fp
         NCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jn7iNHkpfjyvOcSRY1FS0eqnb8a81QxEYqDJzIKy0rg=;
        b=6/RHw4HgwAI0O5Xv94vFce9qhFHM6B86eiDjOSNX8omAXcmlOVz9gE03KQ92bT5WGg
         RhhTjD6FBxnUHoYVbCCSdBiXsqj7wUglNbAGAKC7OLAkmLuGVohAjXPttr5aQCS1ygi5
         nuIscw/BZe0VJquXftmoaBxRkR4kwu+j87Uhmad/XV3WEgAnK3l9hZMQXtly3m0u0X6Z
         OHTnmURR/32Xa05EXY7a4GKxXf9C4RuKYdcJoTU3bN0lElIKQy+Hyv6wzxa/ATe0ld7r
         Ia2CK8GJjiEbbtnKwb3aK5Cw97HZXHAHAhqTrnrlnOMeJa3WlTAVyn4IE5sI2ox5yxDf
         xl7A==
X-Gm-Message-State: AJIora9uUEiBXzeoDLCVqQg+pMAuHeNJQZiDCmjZalfy9oFKuEPaQrOv
        wkTW0ixjSG9pvo6cnIrkAKqGPxFQKJ0=
X-Google-Smtp-Source: AGRyM1tXf55v379ZCanytz5h1ko9t5wwHGJa2S8Lwk2iHnQvBdetk7cvhPuE/58cGwUhBYcVeoRFyQ==
X-Received: by 2002:a05:6402:2b8f:b0:43a:66d4:a025 with SMTP id fj15-20020a0564022b8f00b0043a66d4a025mr2082333edb.121.1659075791866;
        Thu, 28 Jul 2022 23:23:11 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f2e:6989:9a7f:5736:fb10:795a? (p200300c78f2e69899a7f5736fb10795a.dip0.t-ipconnect.de. [2003:c7:8f2e:6989:9a7f:5736:fb10:795a])
        by smtp.gmail.com with ESMTPSA id w1-20020aa7da41000000b0043a4de1d421sm1839407eds.84.2022.07.28.23.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 23:23:11 -0700 (PDT)
Message-ID: <90a16ffd-5a08-0ed3-280e-bd5c4522525c@gmail.com>
Date:   Fri, 29 Jul 2022 08:23:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/3] staging: rtl8192u: move debug stuff to its own
 file
Content-Language: en-US
To:     Tong Zhang <ztong0001@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <YuDdHMaB6jWARQzA@kroah.com>
 <20220729035230.226172-1-ztong0001@gmail.com>
 <20220729035230.226172-2-ztong0001@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220729035230.226172-2-ztong0001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 05:52, Tong Zhang wrote:
> This is to prepare for moving them to debugfs and fix rmmod warn issue
> when wlan0 is renamed to something else.
> 
> Reviewed-by: Dan Carpenter<dan.carpenter@oracle.com>
> Signed-off-by: Tong Zhang<ztong0001@gmail.com>
> ---

When I applied your first patch I got this hint:

Applying: staging: rtl8192u: move debug stuff to its own file
.git/rebase-apply/patch:399: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

Not really an functional issue...but

By Philipp
