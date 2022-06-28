Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D9655DAE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244811AbiF1FOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244680AbiF1FOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:14:05 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D3275C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 22:13:33 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 59so18538144qvb.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 22:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=me-ssier-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=kF0TVeiT2haFltgoqbJILN1oxVvcGv4SSoCvDNYOas8=;
        b=wSlIqbm7D6ZerdlLJ7QM4QdLjWQzMufmBqkQfMnYG12junSlU39G1nPk/pkIir30Y1
         5PL7HAtt/Fp/iOKKKZOXOXy/NVOdA9LXZmfl2dLxwtqfR0B7Z3Pi27Ku3FrM0BvF0Jnw
         GI/ZADuR91XhP5k3OIcn/2g81tIjlhT6w1E+snEuTCZ2m5vY0xTF5tVUMp7CEaQdcHBF
         RawtGe4Jh2iqbMhNiVPji4gA8gRzBomGLwKTQEtSqUbfQ7GjV5RwdzG9epw+i1UDMY7L
         Hu7rKwfaMR7R3vXdSzqEKAEQAKJv95RouSMsvySZ7VfMBh6c/FkTE1t/d9TTt4lQbZOV
         S22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=kF0TVeiT2haFltgoqbJILN1oxVvcGv4SSoCvDNYOas8=;
        b=SktN2K6dy5o8hNS4tQNyWccGq6Q9o+gMsPsaVrI3jVfNon67AMpNN1EIqQ5uNcn/ZR
         7OWh7QWxYkQIQNM0xeyqBMcN4YOG1eqzlb+RJTr7v4of/aUMYA0UymH2Gk+ooQgQCmoR
         WzSD0P7KwjL+9MY6vFSYo3HaY9RXGp/fKmMORO+Grbr8bqeKQIGoeRlFbhvvXwmuiB6H
         lMup21zXXesOVTyl0I4wnYk+00f7W1kZmpcvpZLDqXvvy14yNSq8zVgAm9m7P/eXF6yS
         cYNm/XAIwlptSXkBSGTLsg9xD+5aYiZTWQrdfy112yA1v+Q6lqT2/cMoZnnwT02QNDZW
         g57w==
X-Gm-Message-State: AJIora/FqGEC7zJx0wC15OnH+ghZhcYhyQEPafFcXtF0zsHSD1qhOQri
        fv7O4BQ3VA9cW4bEoftgncCAoxlKpx3w4N2/qBQ=
X-Google-Smtp-Source: AGRyM1tbhNbLSVOTeFsQrWeXL+JQWb00FEOxr1G6HLMQ7x9eqY3vuSw7GeagoX3shKYWmDut4EmlgA==
X-Received: by 2002:a05:622a:1791:b0:317:76d8:d17f with SMTP id s17-20020a05622a179100b0031776d8d17fmr12128764qtk.82.1656393211680;
        Mon, 27 Jun 2022 22:13:31 -0700 (PDT)
Received: from [192.168.2.14] (bras-base-stggpq3702w-grc-11-142-115-210-184.dsl.bell.ca. [142.115.210.184])
        by smtp.gmail.com with ESMTPSA id 14-20020ac8594e000000b00304fc3d144esm8937106qtz.1.2022.06.27.22.13.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 22:13:31 -0700 (PDT)
Message-ID: <6025678c-e94a-6966-e298-82fad658a889@me.ssier.org>
Date:   Tue, 28 Jun 2022 01:13:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Andrew.Cooper3@citrix.com, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        regressions@lists.linux.dev, Alexandre Messier <alex@me.ssier.org>
From:   Alexandre Messier <alex@me.ssier.org>
Subject: [REGRESSION] Unable to unlock encrypted disk starting with kernel
 5.19-rc1+
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NEUTRAL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tested 5.19-rc4 on my system that is currently running 5.18.0, and came
across an issue when unlocking the encrypted rootfs disk at startup. The error
message is:

device-mapper: reload ioctl on nvme0n1p3_crypt (254:0) failed: No such file or directory

The kernel log shows:

device-mapper: table: 254:0: crypt: Error allocating crypto tfm (-ENOENT)
device-mapper: ioctl: error adding target to table

I tested the previous 5.19-rcX, and the issue started happening with 5.19-rc1.
A bisection between 5.18.0 and 5.19-rc1 identifies the following commit:

8ad7e8f69695 ("x86/fpu/xsave: Support XSAVEC in the kernel")

I reverted that commit on top of 5.19-rc4, and unlocking the encrypted disk
works again.

Some more information about the system:
- CPU is AMD Ryzen 5700G
- Userspace is Debian Sid
- The encrypted disk setup is a default encrypted rootfs, as configured by the
  standard Debian installer

Please let me know if more information is needed, or if some tests are needed
to be run.

Thanks,
Alex

#regzbot introduced 8ad7e8f69695
