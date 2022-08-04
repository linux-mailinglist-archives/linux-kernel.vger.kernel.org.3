Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EB058A039
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239736AbiHDSHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239802AbiHDSHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:07:05 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B36D6BD66;
        Thu,  4 Aug 2022 11:07:04 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id w6so193244qkf.3;
        Thu, 04 Aug 2022 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pLCLBYHLKs50i+b/Hxt6DeYaIOPVaEwhLTpxPM25R3I=;
        b=hHXlGIc5mQRz00U8a9YO7hh259T1XV6JNid3qUG/qkNHQjNO5QbQVJOobQzEcHQ8Nc
         /LdFYMVmU4amaieIDFZ1+XHR075hkcWCFn/7+m4/w+0A/VrD75Tel54IucYRPJdsxqm8
         YYvXSooPgaYZ2jUmW805yuxbfOQjsizHBXqm91zslwVH4dwrdxy+yjrgoWNtpjV8m7K2
         ezvnKLdxzbgHQBc2r1Qkb/YyfZAUCipYs295zfP2VC4XAad7dCVR8gqYU9JzeQ0AlvQd
         VumEXkMIF2HPmzcYP8Yd9rVpWf6ebaySfkap30NM8LQmURLaIOPHbpO+xUSpvzXuZKCX
         XxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pLCLBYHLKs50i+b/Hxt6DeYaIOPVaEwhLTpxPM25R3I=;
        b=yEeTmz4om03eKavXA1iDUhAHN5P4gw4TBo16uj6km7LfOzO2Bs58utFLov14UAuMnM
         IiO3i6w6Yj9p3ROsD5AeJ/sqElKFp2uAthi+YHYoo6Vm9i7q7xc3kSRKf8wRkI8lb5CO
         3MjWYzH0bSAkbMIlelZt8lVm1utNDQPF2RtLTplkCu0yo9XWRitumWJIdCAdCpC1MA4b
         X9vJ7TISE9I1hrsEEYwe0Wixab4jG+jqZ6NOTtXq0zF9tTZYF7ShxhSrii5TwjC1PDuy
         z7HMtBsv8hd96omILGu/FVnDQB5wg3jfonf38dfzNwtrBHBCbcocThPjnwu3TqR3Lic5
         dujw==
X-Gm-Message-State: ACgBeo27JuVmzxMLxGOY8mARUUyf2wiiy6ZlMPVEvbCdIdPl565k7jvr
        JGuvv4HL68LU2j2jXHJkrHYBmgVq7Us=
X-Google-Smtp-Source: AA6agR7jgcjVdWcU8Vhis7IDGntP8D+LRwd5S5QE+FKu2VPaHjX/A6gEwjz9f0GrUHQjAdiwJtlOfA==
X-Received: by 2002:a05:620a:4620:b0:6b6:28fe:58b with SMTP id br32-20020a05620a462000b006b628fe058bmr2281494qkb.646.1659636423608;
        Thu, 04 Aug 2022 11:07:03 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x131-20020a376389000000b006b5c80e2b6asm1074786qkb.12.2022.08.04.11.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 11:07:02 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     kursad.oney@broadcom.com, dan.beygelman@broadcom.com,
        anand.gore@broadcom.com, joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ARM: dts: bcmbca: bcm6846: clean up psci node
Date:   Thu,  4 Aug 2022 11:06:59 -0700
Message-Id: <20220804180659.1339443-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801194647.29437-2-william.zhang@broadcom.com>
References: <20220801194647.29437-1-william.zhang@broadcom.com> <20220801194647.29437-2-william.zhang@broadcom.com>
MIME-Version: 1.0
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

On Mon,  1 Aug 2022 12:46:46 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Remove unnecessary cpu_on and cpu_off properties from psci
> node as they are only needed for psci version prior to 0.2.
> 
> Fixes: de1a99ac0b64 ("ARM: dts: Add DTS files for bcmbca SoC BCM6846")
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/fixes, thanks!
--
Florian
