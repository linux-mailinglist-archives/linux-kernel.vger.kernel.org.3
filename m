Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6686750CC8C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 19:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236381AbiDWR0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 13:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDWR0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 13:26:47 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE0114B66C;
        Sat, 23 Apr 2022 10:23:47 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q7so7581645wrm.5;
        Sat, 23 Apr 2022 10:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gOeGhsw9YsWvUbFAKiv+8FpM8AEgNtP62ndxy+K37CY=;
        b=qvfITE+MFT2kmzc1QZflvKs7xyI+JHBxwfhmsYhbqnFtXIrxq+vdD/5pVg5L7O4iuT
         2PpOj4dbtJ5KdzAeFWly5C1f5vuvWb9gL3iDQbHGyHS4b/4jkyJQerZe0uhpTmuBhfYb
         YlraWV38Q5wndwu86jqLUR2ErlYyBXyFvVRDDqhxZYnJei62+n/Y+0c+ThhTziLS7Us4
         ZCyH9vue794zMHxYraHc2vK4bbUvKikgPVGIBJAkUzT12h7flm17XRALDXAyIb0wGF87
         7twlFdXD8K6q1ho95ONbZ8OFRuNiUhwCYdEAHxvu4ReptMNnSSnD07pnIVu5/Fut+kmx
         F+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gOeGhsw9YsWvUbFAKiv+8FpM8AEgNtP62ndxy+K37CY=;
        b=qE+F5E9+9a8lNw8beZ1SJcbY797VBLzK5JrnUm9Zoxo11OqXNP5H2Xuhk0KW0WcsJP
         UUI01DlCNJmzOERMQgCc05fv6lnWBYBvWQJiYqeRDfvb7Tqhhy3iKUgdc7F1Vf22OES5
         riguf4XK8Rsp//YHdc5mgxYRGgXyb77nZubGgcVkzzYJx/Z9lnZIMtNJfURDoTGPNOPO
         UsslGi/H5TUHVWZcgEuJc7hzpym4+4p24PSDUVtOGfNc8OzQsBnL+Q9+hZf++YG3X3Oj
         q5+BtX3RJ0W9eLgmfdByuXrjpiZp963Jp8V5JuZvuWLBrDgGaBde6Dl1JFdWOKDu5wpe
         u8mA==
X-Gm-Message-State: AOAM530bIs4x9xcRFdQhsesXoTA4vjA13pAwBvp7guWeGUJ3GkVW7A7M
        5cPh35T4qsmhn0EQHsT2Sn8=
X-Google-Smtp-Source: ABdhPJzMdu0dmGmnJmBRCaJq8Ag1Saf8ZKij8MnHGKkGEcMOdNAVjRmivzu9ab4WXNBm6xXRzVm3OQ==
X-Received: by 2002:a05:6000:111:b0:207:ac77:3d07 with SMTP id o17-20020a056000011100b00207ac773d07mr8113500wrx.136.1650734626185;
        Sat, 23 Apr 2022 10:23:46 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b0038c8fdc93d6sm6880364wmc.28.2022.04.23.10.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 10:23:45 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     stefanberzl@gmail.com
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: Re: Status on hid xppen patch
Date:   Sat, 23 Apr 2022 19:23:29 +0200
Message-Id: <20220423172330.32585-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <941a793a-d2f7-9c2c-59be-b3930e1acfec@gmail.com>
References: <941a793a-d2f7-9c2c-59be-b3930e1acfec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello everynyan!
>
> A while ago I sent in a patch to add support for newer Xp-pen tablets 
> that even made it into patchwork:
>
> https://patchwork.kernel.org/project/linux-input/patch/b401e453-9c66-15e3-1a1d-21f33b7a64e8@gmail.com/
>
> I have never actually gotten any feedback on it though and am wondering 
> if everything is to your liking. Anyway it doesn't build against the 
> current tree anymore. Assuming there is any value it, should I rewrite 
> it against hid master or hid uclogic?
>
> Many thanks
>
> Stefan Berzl

Hi Stefan,

I just saw your email in the mailing list.

Your patch doesn't apply against the current tree because of the changes
from Nikolai/the DIGImend project I'm sending upstream. For reference,
here is the latest batch of patches, with links to the previous ones:

https://lore.kernel.org/linux-input/20220421175052.911446-1-jose.exposito89@gmail.com/T/

Please note that I'm not the maintainer of the driver, I'm just a web
developer who does free software as a hobby, i.e., this is not my area
of expertise, so take my words as suggestions, not as the path to
follow ;)

The development of the uclogic driver takes place on the DIGImend
project (inactive right now):
https://github.com/DIGImend/digimend-kernel-drivers

Like you, I wanted to add support for my tablet/improve my kernel
dev skills, but I noticed that I needed some patches from DIGImend, so,
instead of taking what I needed, I decided to upstream all the patches.

At the moment of writing this email, 24 patches from DIGImend have been
merged, 5 are under review and 7 more need to be sent. We are close to
the end.

My tablet (Parblo A610 PLUS V2) also needs some magic data to be enabled.
Actually, the data is pretty similar to the one in your patch.
You can see my implementation here:
https://github.com/JoseExposito/linux/commit/f1f24e57fab45a2bcf4e0af5ba9d8f5a2245670b

I just refactored my patch and extracted the code to send the magic data
to its own function (uclogic_probe_interface), so we can share it.

I'd suggest rebasing your code on top of DIGImend's code + my patch
so we can share some code and once all patches are upstream, you can
send it with minor or without conflicts.

What do you think?

José Expósito

