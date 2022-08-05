Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB12E58A644
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiHEHAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiHEHAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:00:04 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245305B7AE
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 00:00:03 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id m10so1224443qvu.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=V23YyaSN3DWPPYAn9D9n416ps4WPEzww+UTnDIeOTcI=;
        b=QF5IDfDmB2zNU4hnSxsegVdLhkty0mmkn1IW57VVuO8HsCl1pEPeQp7v6hFNsLZaWb
         GU5TxBrIOyt476ie8/a4vxM8Y7iuWNOE5Si3nxeWYqwW66Aj+Fv0nXzou28b+KDZ4y0R
         3kTwJVd8vCrvoChn3myvdLZ8MX8UJSus/JpAgW7surhLnzVYSTGHG5mQOMqirp8LKlAM
         li6SuBuSf7pQa+s7vcEt5pt7hZjxxomNbGTJKRlRWFsvH9RMJBBvSKL5UJd4afgcGLpr
         CLieZNi7TI+Lsr6Vha/X3RdpkcxkGQWSaqXQMxsqOa4LP6ZfU2wJejosrRJGvyc15a9T
         j8uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=V23YyaSN3DWPPYAn9D9n416ps4WPEzww+UTnDIeOTcI=;
        b=wQzMXTzf01VHkx5fs1s2OEHPXu3xhRX9HE/ZMduUwm/ff/x4oxogREXPQcWVrSt6MO
         obqZtbfxYAWrgs76aWfRnwOV6TRk06A9WvzxPeT04R4gKBrs6QH5ByIZ++OmGCFAnTff
         a790adwCKqszj8XNfKi+S+bvZo4EuCyy30+TlJThoaUUHfad/Ye59QgqKDRKnI8WxV4m
         GeBXMFjccMIEYCKHd7ZyTDVXX2ccWT1mpcU+fT0V8HuOxf2Ezx1EdGesej7L568frDql
         1KnppJnxTDqRZp/GmnIXLc1lkSwfo4NrauAE+xTyESQewnnOtA7PvJspoUV5NNVRHXfm
         vvJg==
X-Gm-Message-State: ACgBeo2zdv98FfgAqZzCLiVCAQq5AryiP4Q66Du6Ci1QiMjcQCaKKMBk
        kuI7MQWcgIOQmB7oPrtlMTK5PhFueg4=
X-Google-Smtp-Source: AA6agR4heZNqSplr6DnILMFOQdgIjXozlfO0bTixAhsw9AHaZRt1GwPZQnoQLLQWaNkdG99YiEevvw==
X-Received: by 2002:ad4:5ca9:0:b0:474:9143:6ffc with SMTP id q9-20020ad45ca9000000b0047491436ffcmr4521027qvh.19.1659682802149;
        Fri, 05 Aug 2022 00:00:02 -0700 (PDT)
Received: from [10.5.100.6] (modemcable117.130-83-70.mc.videotron.ca. [70.83.130.117])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a0ed500b006b615cd8c13sm2181708qkm.106.2022.08.05.00.00.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 00:00:01 -0700 (PDT)
Message-ID: <7e3dca87-54d9-b67c-4c69-91ccd470aa82@gmail.com>
Date:   Fri, 5 Aug 2022 03:00:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Content-Language: en-CA
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Denis Roy <denisjroy@gmail.com>
Subject: Kernel bug starting after 5.13.0-35
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject:
Kernel bug starting after 5.13.0-35
From:
Denis Roy <denisjroy@gmail.com>
Date:
2022-08-05, 2:52 a.m.

To:
"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


A couple of months there were repeated kernel updates, then one of these 
updates prevented me from booting into Ubuntu . After testing, going 
back to 5.13.0-35, everything was as it was. Any version after that I 
can’t login to Ubuntu.

I have a MSI MEG X570 UNIFY motherboard with a Sabrent 1TB Rocket Nvme 
PCIe 4.0 M.2. I have also, a sata raid 0 encloser for two 2.5 drives, 
AMD® Ryzen 9 3900x, Radeon RX 5500 XT MECH 8G OC

Obviously Ubuntu is booting from my nvme drive.


