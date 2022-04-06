Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A784F66E2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238790AbiDFRUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238786AbiDFRUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:20:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED774929C6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:17:56 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j12so3740540wrb.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=ep0L9P2iyTWPsPhU47glyvJj+YI4VUISjQ8ioA9AgqM=;
        b=d6qVY29u/1z2usp0R/GfeougW9R+xKm6zwQWev+y0feICkogaEZox06UfMYWYXAr67
         bvWvHfdPso4RzJwqojptWYBU5/TepUEOESoASeQYIDYXsDjp/VBImsQOlWPaY+DB/cT+
         48Yluq2bsmTE1hXhkGIfj1qkh7NN9KPYP+iv+FXpCEaoJHn/b4jyUsvddMFoztWT2FWx
         1QB83eQlwj2vN78ZKp6+NfHXsufAnaKy05rMgLCbIS/t+qGSvkohbVq6ahUpEDMoVVKE
         oyUzbmB6GSW381ZNOzr+P/fbfturupSga2QzGlqY9KtreYj38ZglF8aM6DrD/T48CjKs
         eIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=ep0L9P2iyTWPsPhU47glyvJj+YI4VUISjQ8ioA9AgqM=;
        b=vmaRzLZNUsq4Kbr6uSzSPYWZp1fJ4acCWPkKuOUwC57RLn16pbd3Zsh7DX7vPtM6mW
         KCGneOYBrPhfeSuM2oYSwwWlX2bpNoahuqeJH0emf+IaOT2WlxqXtZCA1oNlwkeGHCxM
         JleKWHyF1qlgFHcfqyFNEdNm3CITuZz36VzM6jFFsaDoAhPW8/XXz9bubGkIUe15WM1t
         77CcIEelCKSJdpp+S7FfguvFpXGEHtOehLweWNVAPzhxc+n8/C7917/hcfvVJ2xkiQX5
         ZZ+bHNwM7zMahYdQj39aBXpxBCH8Ay38QZnczmudjfW3f/o9YfnzDCZ0lY/xLMvkYUFS
         QVRA==
X-Gm-Message-State: AOAM531BKAqKcs7cbGyxcixXCXyyi4Q0a/OfW/jV7MJ96TJkiSEXEzOJ
        Jh9cvVLXbIT3vhxq4M0Z2pc=
X-Google-Smtp-Source: ABdhPJxVqkYwEtjWoZ8e8nC0m72WuobT+1OGSuN4+LNUxsABQfk26FmxyBzDBPy7QR3NElRPjVXWfg==
X-Received: by 2002:a05:6000:1e16:b0:206:40c:872d with SMTP id bj22-20020a0560001e1600b00206040c872dmr7042429wrb.535.1649258274775;
        Wed, 06 Apr 2022 08:17:54 -0700 (PDT)
Received: from [109.186.89.7] (109-186-89-7.bb.netvision.net.il. [109.186.89.7])
        by smtp.gmail.com with ESMTPSA id a11-20020a5d456b000000b0020406ce0e06sm14568547wrc.94.2022.04.06.08.17.52
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 06 Apr 2022 08:17:53 -0700 (PDT)
Message-ID: <624DAF08.9080304@gmail.com>
Date:   Wed, 06 Apr 2022 18:17:28 +0300
From:   Eli Billauer <eli.billauer@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Hangyu Hua <hbh25y@gmail.com>
CC:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: xillybus: fix a refcount leak in cleanup_dev()
References: <20220406075703.23464-1-hbh25y@gmail.com>
In-Reply-To: <20220406075703.23464-1-hbh25y@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I stand corrected. Thanks a lot.

    Eli

Acked-by: Eli Billauer <eli.billauer@gmail.com>

On 06/04/22 10:57, Hangyu Hua wrote:
> usb_get_dev is called in xillyusb_probe. So it is better to call
> usb_put_dev before xdev is released.
>
> Signed-off-by: Hangyu Hua<hbh25y@gmail.com>
> ---
>   drivers/char/xillybus/xillyusb.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/xillybus/xillyusb.c b/drivers/char/xillybus/xillyusb.c
> index dc3551796e5e..39bcbfd908b4 100644
> --- a/drivers/char/xillybus/xillyusb.c
> +++ b/drivers/char/xillybus/xillyusb.c
> @@ -549,6 +549,7 @@ static void cleanup_dev(struct kref *kref)
>   	if (xdev->workq)
>   		destroy_workqueue(xdev->workq);
>
> +	usb_put_dev(xdev->udev);
>   	kfree(xdev->channels); /* Argument may be NULL, and that's fine */
>   	kfree(xdev);
>   }
>    

