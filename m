Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF09489897
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 13:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245476AbiAJM3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 07:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245488AbiAJM3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 07:29:34 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A8BC06173F;
        Mon, 10 Jan 2022 04:29:34 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id i8-20020a17090a138800b001b3936fb375so6838673pja.1;
        Mon, 10 Jan 2022 04:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rBfRzRO7n13YTizN2EeFImg/FwnKSMH4zlIbjLIB3Iw=;
        b=edRxPRwRwzOSpdTmZxLrLLZyT2oPGeI/wY2NAnbPvNEDSwEJwp2e8WoQKfQy9oZeT2
         f9TfFmwT+8Vj8hDyRLnCTa6HfpyGXg1Jb3/8fUl37nhSEDHetHIycGqyRhqFudzyT986
         /oiQjg1QR1Op5R7hi8tQ2sHdOnjpHoAR/ONXpnb3jPe3gAglNGT4giHy9yRi3DRsZ24t
         55t2Ti4XH4zxeHbgITVHtgX0TcJC0aoflX9giyA4L8bpqR4/BS55RdxG3GtC7DCDU41n
         ImQsyzzi+vFETZK/UP6/Q1PZQbqKen8ynucqb7Na3XxN9GrVbzGeHPSuuuGmjTETdH6Z
         dBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rBfRzRO7n13YTizN2EeFImg/FwnKSMH4zlIbjLIB3Iw=;
        b=fiSzPJxWu6A4wt6mL6S1nDDTW0a2JdPky2w5ofml4cgt9MW6ecFcnhUKVLOYZ4A1tu
         kuHUyytcOhOV+8Fg8+ynrev/yCwbUL9c4mFGRMK5Elf1nQx3ezZ3HZfW2V68fv3Fctba
         b3U4Tg2KIPQCSlqcQO4SkJnju1TCULhmMHkXPc7LKU9q6r7kLwtr69gEchQm7QVnAzj8
         QHerqayLghGgz+yj9FlOlksv1olt/gdlLsOqIbiwVmDjZR2aDMUicVm6RI110XEoWc7D
         cX5BMWmMgdtf7sAPsxiBnYwQaXyBb+nzcmZ2DEqdYoQSb5XpmG3mn4TsAcg3Qj7Tow/n
         RsDQ==
X-Gm-Message-State: AOAM532eJdUnLHVPEKGJmHwli+FrYSXkC0bxTmfk0j00dUexSNb3N8A/
        gbtYm0MdtD4gvhdwdZYgClk=
X-Google-Smtp-Source: ABdhPJw2X6GVrl8WgOo8PMcCuQqkff+R4SkYON+2Ndpxxs0vtLuF1KG8qbrCdchruPrZNb2CtfYAhA==
X-Received: by 2002:a17:90b:4f82:: with SMTP id qe2mr29843162pjb.128.1641817773951;
        Mon, 10 Jan 2022 04:29:33 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f10sm7426565pfj.145.2022.01.10.04.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 04:29:33 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     alexs@kernel.org
Cc:     xu.xin16@zte.com.cn, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add four translated documents for KSM
Date:   Mon, 10 Jan 2022 12:29:29 +0000
Message-Id: <20220110122929.647573-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Add four Chinese translation documents about KSM. They are
1. admin-guide/mm/ksm.rst
2. admin-guide/mm/index.rst
3. vm/index.rst
4. vm/ksm.rst

xu xin (4):
  Add zh_CN/admin-guide/mm/ksm.rst
  Add zh_CN/admin-guide/mm/index.rst
  Add zh_CN/vm/index.rst
  Add zh_CN/vm/ksm.rst

 .../translations/zh_CN/admin-guide/mm/index.rst    |  47 +++++++
 .../translations/zh_CN/admin-guide/mm/ksm.rst      | 156 +++++++++++++++++++++
 Documentation/translations/zh_CN/vm/index.rst      |  49 +++++++
 Documentation/translations/zh_CN/vm/ksm.rst        |  77 ++++++++++
 4 files changed, 329 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/index.rst
 create mode 100644 Documentation/translations/zh_CN/admin-guide/mm/ksm.rst
 create mode 100644 Documentation/translations/zh_CN/vm/index.rst
 create mode 100644 Documentation/translations/zh_CN/vm/ksm.rst

-- 
2.15.2
