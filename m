Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C83B4FF78E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbiDMN0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235635AbiDMN0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:26:44 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB825BC11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:24:20 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id a19so2029905oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 06:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=GkPu+VzqLRa8FBFCQSr+DQfeLMBrMIqhtSL0YhCubSF+uM5tS8sTuWEUqwysHVYkRO
         3wyGd9EnvvL2XOfL9cphBUBh6OVk1Ihwvna0b5ut+Dwj8wIWtor/6mL4ebQCumXXTLCz
         N7FfAXey5gD3IFXGbZZ2LhUdX2Q9O8An47MApJ33QIRoIM3AvIxSUud2dYczMOoOhlfG
         7efP7ZgQBkc2qlKgMLt8+/PsvvbbWvWsgA0aMo2zuYwCJVHX5CXZnG/hRUARFKcKTHTn
         xwgkyKqLxk+L3OrsjIw664A0V315RsP8alG3UnchHSkpoSKrypadHrX1xPbYfQ2bSh35
         a/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=VYcOUGcbzXtqkOMT5S4frcklslRtKi5Wg1KKc90C0MULlJeWrzpMgg2Um377Eveg9/
         qjmGln5y/W4p8R5Q8nNpsWW/NzCDxuSuwKGp8CgAzK3vz44YkFNBovlYnBcoAwclE3Hk
         UkPVHldpL1OSQjxaOiw1kkYZ4QCHXctlHPZDM8qDljf4Q0sXsjE4r4wj+dvtJjUD9doN
         0Q1lfMyygYNywsGgz2b/gCrRjx0H8BqqSc4c/tuaB+FtEP4B8rCcoxCtahaZtVqUq8/s
         gM5pSxtuA9fZSRnsKoBct1sDr/K1FSc07UoIZsmMojJnnAacN0qdYbeu7pO3HZ1c/p4Z
         SzYA==
X-Gm-Message-State: AOAM532mis2kMb5uO+CYZlkreVrLmeGXgXoYELrieHlPTetocO8isBPC
        5Rr/tty/2SD6kDWRXaAHzxOKcEUvWATUgeLiaVc=
X-Google-Smtp-Source: ABdhPJwia+cqS2dGsoN77ARHpjjw9sFk8+LTMJkO/9c9X9eU10metPz0oUN7U+LlsxD67WjPkkabkYXkiazR03cJbm4=
X-Received: by 2002:a05:6808:2018:b0:2ec:c22b:15b8 with SMTP id
 q24-20020a056808201800b002ecc22b15b8mr4118266oiw.136.1649856260074; Wed, 13
 Apr 2022 06:24:20 -0700 (PDT)
MIME-Version: 1.0
Sender: erickone.infor@gmail.com
Received: by 2002:a05:6841:1194:b0:bfc:d042:6840 with HTTP; Wed, 13 Apr 2022
 06:24:19 -0700 (PDT)
From:   miriam yusuf <miriamyusuf08@gmail.com>
Date:   Wed, 13 Apr 2022 13:24:19 +0000
X-Google-Sender-Auth: B41nxYjclSSn8gvWS_Dwz5hyWAk
Message-ID: <CAGEMGJ3+QXk5+tt0pyqw4s5G+2wK4td5SqFJvq6Xp8LPgDGNFA@mail.gmail.com>
Subject: =?UTF-8?B?0J/RgNC40LLQtdGC?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


