Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F285757F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 01:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240868AbiGNXTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 19:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiGNXTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 19:19:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2430749B79;
        Thu, 14 Jul 2022 16:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=XGpd5T1EafVDLNNMFCoN/oDpo1B2rzHEZsGMSXen9LM=; b=KfoBEIF8M1t65cP6ile0m6SP1y
        T8b8W3HkhivO5XCW3uhZjImKuZGVAlVciHCyQBl/7fyol0ozTn7CPJNON9QArYvJD0sFaCBLtnvjY
        uDtmbwvunX+NqDJiW205u5gEQkPMHy97YN1/0Vk+xmgd8znjUfEKLyF9Wfd6+j8Ht1tye7V48IkrW
        yI2CdXSdtfHXa1zSoPrOS9bfetd2GQJeGsh0hsabb3Ue+f2Qje3b5l0BjjGajzZmzJGVHJas/zkXA
        KnLmzQ6panSYUocBfUnCqxK8XhLB27qKWeWQZtGx1E70D9sFaeTh6RVLlsaS41hcA9KfJgrXlQ6Yv
        oUsJQMpw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC86k-002aUy-EM; Thu, 14 Jul 2022 23:18:58 +0000
Message-ID: <ae06388f-a062-132b-ee61-8ad68f227970@infradead.org>
Date:   Thu, 14 Jul 2022 16:18:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation: process: Update email client
 instructions for Thunderbird
To:     sndanailov@gmail.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com
References: <20220714131152.12709-1-sndanailov@gmail.com>
Content-Language: en-US
In-Reply-To: <20220714131152.12709-1-sndanailov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/14/22 06:11, sndanailov@gmail.com wrote:
> From: Sotir Danailov <sndanailov@gmail.com>
> 
> The instructions don't match with the current Thunderbird interface.
> Clarification on using external extensions.
> New information on how to avoid writing HTML emails.
> 
> Signed-off-by: Sotir Danailov <sndanailov@gmail.com>
> ---
> Changelog since v1:
>  - better external extensions explanation
>  - information on avoiding HTML emails
> 
> v1: https://lore.kernel.org/linux-doc/20220713225037.1201-1-sndanailov@gmail.com/
> 
>  Documentation/process/email-clients.rst | 64 +++++++++++++++++--------
>  1 file changed, 43 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/process/email-clients.rst b/Documentation/process/email-clients.rst
> index 16586f6cc888..229cbde5b62c 100644
> --- a/Documentation/process/email-clients.rst
> +++ b/Documentation/process/email-clients.rst
> @@ -278,35 +278,57 @@ Thunderbird is an Outlook clone that likes to mangle text, but there are ways
>  to coerce it into behaving.
>  
>  - Allow use of an external editor:
> -  The easiest thing to do with Thunderbird and patches is to use an
> -  "external editor" extension and then just use your favorite ``$EDITOR``
> -  for reading/merging patches into the body text.  To do this, download
> -  and install the extension, then add a button for it using
> -  :menuselection:`View-->Toolbars-->Customize...` and finally just click on it
> -  when in the :menuselection:`Compose` dialog.
> -
> -  Please note that "external editor" requires that your editor must not
> -  fork, or in other words, the editor must not return before closing.
> -  You may have to pass additional flags or change the settings of your
> -  editor. Most notably if you are using gvim then you must pass the -f
> -  option to gvim by putting ``/usr/bin/gvim -f`` (if the binary is in
> -  ``/usr/bin``) to the text editor field in :menuselection:`external editor`
> -  settings. If you are using some other editor then please read its manual
> -  to find out how to do this.
> +
> +  The easiest thing to do with Thunderbird and patches is to use extensions
> +  which open your favorite external editor.
> +
> +  Here are some example extensions which are capable of doing this.
> +
> +  - "External Editor Revived"
> +
> +    https://github.com/Frederick888/external-editor-revived
> +
> +    https://addons.thunderbird.net/en-GB/thunderbird/addon/external-editor-revived/
> +
> +    It requires installing a "native messaging host".
> +    Please read the wiki which can be found here:
> +    https://github.com/Frederick888/external-editor-revived/wiki

Does thunderbird v91.11.0 qualify as newer or older?

I tried to use the external-editor-revived yesterday with v1 of the patch..
no success.

v2 of the patch has more useful info (about native-messaging), so I installed
that and still not happy.
After pressing "External Editor" in a tbird reply window, nothing happens.

Wait -- hold everything!  Exiting tbird and reloading it
fixed all problems. :)

Thanks for all of the updates. (says the file's original author)

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>


-- 
~Randy
