Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625F54B080F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237310AbiBJIU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:20:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237267AbiBJIU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:20:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DD210B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:20:58 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id i186so9037825pfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Krb0rzTOGW2eoN3LEJWPKbRX68tZZeijjPHmNpJEiuw=;
        b=X4RptU//lXEDz6B2GaWL43her2cGYbE8ScvsaqQ3JDFxx7ikqIOgZzJmDbrBWJYIH5
         qFWOEB6GALcHvoB9kXYuJR5deJQVuDVhdvONH8VdK58lVe8RJJ2CzniSMQ1IT643zYW3
         PN6gZCJ+G6BNsA4cbPKAjvuqSwBnwSOnQBKnoHWK9neRlFGmQHS9sscwrzLpDjmqa+P5
         FUlmw9/4CLC4p9yw8X3lg4aFSRFRPZ4EbOESz6GaPBadEFPM+5bEuIrlN0ioqc3YgVm4
         1Klc4wADjbs44eiQkPkkcIcqBJ7+CDOGUnPiLqXW+ynjBDI23rBhQQPAaQd3wWK2OTkO
         QWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Krb0rzTOGW2eoN3LEJWPKbRX68tZZeijjPHmNpJEiuw=;
        b=haABHRtXATMxYd/31RdV6+yt7fMr9ASM+VW8n1xnuAwCKs++YALCtVoUfft18sVGq+
         w5VVeB8Qm3+Mzf1Da2+XRdzaU8qS4M1jUOpbwavvx1b3JOmBG73xhDt/WPFcGpQ4O534
         +0w8GSzQftcGKrisNhMG0PpTYw//zLY4zmXIO8Tc3AoJomqNLw97ltqV40Np9EqhKrpU
         2PAe8g1983hms6b/X0FIpDsTd4R3Gs9uYpcMbcmYsK5pHWm0qgqloFzP4BzxfsRX8Xsv
         FjCxkTtZONOTXjwoqg0Cf1G3mYo71fLDCQPQp5AYIGWzDQQyFOA7p73QL3FjrZd6ErQO
         04Yg==
X-Gm-Message-State: AOAM530QrmiXGi4mJbtyhy7/9qi7qsS8AmUYe0hQF+IQMqW3CSCy+uH1
        TxytnBBw1UDGloxST/29UL9DjW4+w8DkfA==
X-Google-Smtp-Source: ABdhPJyK+1a3UQV6u+LP1EI1H/P04vpG2Owo6ZPLmkdSsqC12revmFlKMy2HiNOC46200H7wPK8xIg==
X-Received: by 2002:a63:81c8:: with SMTP id t191mr5242468pgd.321.1644481258472;
        Thu, 10 Feb 2022 00:20:58 -0800 (PST)
Received: from [10.76.15.169] ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p4sm21374590pfw.133.2022.02.10.00.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 00:20:57 -0800 (PST)
Subject: Re: RE: [PATCH 2/3] virtio-crypto: introduce akcipher service
To:     "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>,
        "mst@redhat.com" <mst@redhat.com>
References: <20220121022438.1042547-1-pizhenwei@bytedance.com>
 <20220121022438.1042547-3-pizhenwei@bytedance.com>
 <15e960491a684b649e5d0179a32848a2@huawei.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <540f29e4-12ef-3786-bd54-9a94ba6ee7ab@bytedance.com>
Date:   Thu, 10 Feb 2022 16:18:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <15e960491a684b649e5d0179a32848a2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>   /* The accelerator hardware is ready */  #define
>> VIRTIO_CRYPTO_S_HW_READY  (1 << 0) @@ -442,6 +520,7 @@ struct
>> virtio_crypto_config {
>>   	__le32 reserve;
>>   	/* Maximum size of each crypto request's content */
>>   	__le64 max_size;
>> +	__le32 akcipher_algo;
>>   };
>>
> You can use the reserve attribute. Keeping 64-bit aligned.
> 
>>   struct virtio_crypto_inhdr {
>> --
>> 2.25.1
> 

Can I use the "__le32 reserve;" field directly?

struct virtio_crypto_config {
         /* See VIRTIO_CRYPTO_OP_* above */
         __le32  status;

         /*
          * Maximum number of data queue
          */
         __le32  max_dataqueues;

         /*
          * Specifies the services mask which the device support,
          * see VIRTIO_CRYPTO_SERVICE_* above
          */
         __le32 crypto_services;

         /* Detailed algorithms mask */
         __le32 cipher_algo_l;
         __le32 cipher_algo_h;
         __le32 hash_algo;
         __le32 mac_algo_l;
         __le32 mac_algo_h;
         __le32 aead_algo;
         /* Maximum length of cipher key */
         __le32 max_cipher_key_len;
         /* Maximum length of authenticated key */
         __le32 max_auth_key_len;
         __le32 reserve;            -->    __le32 akcipher_algo;
         /* Maximum size of each crypto request's content */
         __le64 max_size;
};

-- 
zhenwei pi
