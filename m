Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CAF56680C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiGEKdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiGEKdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:33:03 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E278D14D36
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 03:33:02 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id s4so4419607uad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 03:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DGldbYQUlEhF4W0kRHgZ9uk6uojg6Wl5h6CzYhT+eUE=;
        b=Cm3xvpel7figJVK48HkMEGn1kYnXlVR3PP9R4a62ewyIxwHSQHMQsEQST+PYwxnzii
         h+M8wk0VfXlzXWbJqcGMa7FIa10nhPR352kmEN8zmDmI0CMbI+E6uI4UJmMw8vepCGDl
         3CgWXJJRwizGE3oDo2LmR5kh5j4+JB9D8Jpdnx4z+F2fUO4CIMRKBBBDLoS70nQQDEDx
         di57eWE6E6GxCotN7ktGEoFGr8O7v/IklejJIKzAoEdH+/cXHeqkaIpds4OX3iwwykh5
         uNzBjkmu3Y/VrY6NsORVrQ/eIxohdPy+js8NmQA8tmChGLpODx8XLA5QUpy2L92Q9aa9
         nUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=DGldbYQUlEhF4W0kRHgZ9uk6uojg6Wl5h6CzYhT+eUE=;
        b=tVO2xxhMKjFvvEFrYO0FGTO021izi4SglBKcwq84LLUzgeV3s11sFqWNfN+/fXfjuM
         YeXz4T6qwDe+PbHpP6vbgTi+hEorqvP6odj1Grk+Fqk/tD2EYX+v30HJby4RrXIKvLlv
         LeRgEBWMutVQfuEeTV4n57ajFqQ1I8RGtB6XVWVt+6skjeLrJtCfLB3mY2M5Sk+gN7YS
         HqgXEDSv5aW+VOD1KKSObHlq6OiTl/qhKH98rwsizhEDP+VNIlfmzshfX6CfZarWO9JB
         sX9QZkx9TfWHtvphtr8oNfFamy57EHn/TLZUKnSjeotx5sUek6gznFm77P8AyFRyF3cj
         QN8g==
X-Gm-Message-State: AJIora8w37Evli5PUo3VoLN6St1k8vtTYTMgLbG23nOTNcFRNVyaPT5w
        fHX33VpIg7bQmzHOh6+A2xgc5R5Cps+NhAQtct4=
X-Google-Smtp-Source: AGRyM1sTNEqeCIDWQG2/I2pP/OtE89rJCrJ0gS7YO5DWX8jYg0vxNxwUUBBdc8BhvYuiUzS3VCDDzlXWxciOEUVmq4A=
X-Received: by 2002:ab0:1343:0:b0:362:9e6c:74f5 with SMTP id
 h3-20020ab01343000000b003629e6c74f5mr15574224uae.15.1657017181719; Tue, 05
 Jul 2022 03:33:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:612c:58b:b0:2d1:bbfb:95b3 with HTTP; Tue, 5 Jul 2022
 03:33:01 -0700 (PDT)
Reply-To: stefanopessina92@gmail.com
From:   stefano Pessina <hannahgathonikagai@gmail.com>
Date:   Tue, 5 Jul 2022 03:33:01 -0700
Message-ID: <CAKyYqauu7Lvmy3eqKjuTbF-Bn5NDE==xUYqnBkT2HTGupHwx4g@mail.gmail.com>
Subject: =?UTF-8?B?R2zDvGNrd3Vuc2No?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Die Summe von 1.500.000,00 =E2=82=AC wurde Ihnen von STEFANO gespendet
PESSINA.Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen per
stefanopessina92@gmail.com
