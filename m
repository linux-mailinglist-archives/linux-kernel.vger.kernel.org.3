Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEFFF55034B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 08:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbiFRG4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 02:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiFRG43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 02:56:29 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20E929C83
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 23:56:28 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id b13so2900288vko.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 23:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=0w+rluxU4PfeCNSf+Dnj4R3S60szgoM07LQcYRKrfi0=;
        b=gO3ilw0x2LemQN8sZtxvQtky63yzFM5bqc6IHNLIlzoS/z1fPBEghYPUelpWHdpnvN
         QRBRDWjqo6QvytPOeoFefqMbQcCHSveKA6VYUfkOXQFWmAAzQvI2psVlaN8XiKRsePJa
         ZPwbCjPJYOkO4HgOrNxVCuF8VTWT3IO+bDLApL0N/JfHfG41OfgX66DmrHSqUsKMZ/ih
         eSw8KPR/oy716SlyuHD0OJ4N5+Cfasq/DZLd4IGPR8SxRoR8i3y6fcdU+wkYFMDKlx/Q
         zL5p59IR8diTpgQE0bVGen2DC0xUGGLZ6RrG/DHA0OOsZFPjzpFB7DemaRKKjb5ZwPw/
         5GNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=0w+rluxU4PfeCNSf+Dnj4R3S60szgoM07LQcYRKrfi0=;
        b=T2PrjvEmMiqa/CC1kC7V2Nhuzrheuezj5djEQTqU/v6+Qo3s4na1Se5IyC9qpWZMMs
         gbRW8DTtw4/a80yGozg1g2Ce3EmviSIJpMOXK11xO5+n1tW+WJ7LB0lnU8v1ReU+B/NZ
         MM0HRcAc1Y1KXaMjB8LhlCp+QXndSx4OSEdY4aHpejOzLIDHpWjKAQ3wt0sGN0tRSkhQ
         kfiDxmMl6GPiKxfdICEYlIL9Z4SR5gv+iF+DkXYZLRVnE1jw97JS5Z2//lsotZDfJ7W6
         BYc+jLY7JKydIgQ6/AvJNwSyvAqVZ0TgXoNCtJcVKK3W6Mjrkn5sPu+LOPUUov3TKKJ6
         HLBg==
X-Gm-Message-State: AJIora+GG6PxyPmvheeobGqWsiAJdfE7j/dGyP3Y2uQatSAL3+KAN66Q
        D6GhOvRh/rosy9J9w4VDNfi8p/Po4BYxDr7A2vk=
X-Google-Smtp-Source: AGRyM1tHf2MzyMHQGosGeRmPY2uIXOGePiOe6DBcb2kmqu2pIXwsoqsryxiabJcNLl/MQCLRSRK43yXoP38MS1OrOGc=
X-Received: by 2002:a1f:b254:0:b0:345:87e4:17fb with SMTP id
 b81-20020a1fb254000000b0034587e417fbmr6236554vkf.25.1655535387651; Fri, 17
 Jun 2022 23:56:27 -0700 (PDT)
MIME-Version: 1.0
Sender: avedissianaraaram@gmail.com
Received: by 2002:a59:b6c1:0:b0:2cd:a69:4501 with HTTP; Fri, 17 Jun 2022
 23:56:27 -0700 (PDT)
From:   Elena Tudorie <elenatudorie987@gmail.com>
Date:   Fri, 17 Jun 2022 23:56:27 -0700
X-Google-Sender-Auth: dLVBsub0hmom-9p-pJGZM6XS6WU
Message-ID: <CAH926fTSk7cZ4ZErJARSu4KVqtZcCQ5o8MqHyKMPRfszAMmUCQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day,

I will like to disclose something very important to you,
get back to me for more details please.

Regards.
Mrs. Elena Tudorie.
Email: tudorie_elena@outlook.com
