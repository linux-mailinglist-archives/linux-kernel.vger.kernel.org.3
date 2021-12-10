Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC3046F871
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:26:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbhLJB3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235354AbhLJB3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:29:46 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13563C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 17:26:12 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 188so5052729vku.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 17:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=LEc7NFqr3FKAIjT7OCYf7cUapdW8bqBPdFrn2WI98Kc=;
        b=XHZGhu2uF6v/k+oyyzkTFxAkOlOn5qtzzl+GdvbHobSj3l/bfr9w9jM6AxVODFXpQt
         PIjpBvOw+jDjKTI8d+IWhd3ipzehg7CDbPX6tN+UOnn+usSoW4HEYaQ08ECAkUNhLV5C
         qQZIxaq962KBQcf+z9Y+SRmPZZGfmd67IjbEKnJ5bJR7pzCX4KUmkSMsUotnXB2yY+mG
         pQ6Ss61jvUmWdk4WkzCMJFMm1BsvujJfuEwg8Phb0+kzHqPmXG8VUjpApG8+m5ANvU2S
         u3NxJJzgS0GXxk9u8LpTFDDvDcCCgDzS9DmZcGV4vOmljyO3ZvYPvlz6O8hYFdfEHGCY
         O3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=LEc7NFqr3FKAIjT7OCYf7cUapdW8bqBPdFrn2WI98Kc=;
        b=lUhZuHJt88ZcsicnEWc0vWr36IFm5mrU7JhZ4+4z5x/0AM6NREqi3yVhYHT8cD1jn3
         CUgZo8nmjwgvX/9jrJaT3+YQ0gur8FFILj1Ggz1yb51OlFkIt008loqoHTzQlzv0wIWU
         LxxdcZxnUyjgdWebFBP7fro/gF7atxEweMx/fvTjR+NCwdQF3UzGZOHrNAllH32rDpnl
         SGHl3UQq9q8LEB6n6cpG3jvfh0yBxMDkj3V1Ik56d/7H9sDMbgt1yINgHfmBXECvgHI5
         LVju3JaQlemDdC5iSxVfT1a6ivsf7EvCdLekir1bYjTyn65JC8lFqPpobcmdBY31yrt5
         TzcA==
X-Gm-Message-State: AOAM530TANonNPbPlM0mNEWWRyAPdDo5oj0X3xtG5zN8y33cF5Cniajs
        AkZEvP0kPFYSzlnApc+pTn85P4cZtqi1oMsjqBI=
X-Google-Smtp-Source: ABdhPJxg8sKC7NfDG/pJN8z6JKOVWtWgnEuYFbiN/MGpWKev72FGSedPWn8X/oRr8+eMZxoWnLWmKwiQk8df4HV97Pk=
X-Received: by 2002:a05:6122:99b:: with SMTP id g27mr14855291vkd.14.1639099571129;
 Thu, 09 Dec 2021 17:26:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6130:395:0:0:0:0 with HTTP; Thu, 9 Dec 2021 17:26:10
 -0800 (PST)
Reply-To: payenjane100@gmail.com
From:   payen jane <io452404@gmail.com>
Date:   Thu, 9 Dec 2021 17:26:10 -0800
Message-ID: <CAA+kqzz8aAp+hvChs_07sOyehQBMGha1u7MR=0w+0rwbQsQdmw@mail.gmail.com>
Subject: =?UTF-8?B?5oiR6ZyA6KaB5L2g55qE5biu5Yqp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5oiR5biM5pyb5L2g6IO955CG6Kej6L+Z5p2h5L+h5oGv77yM5Zug5Li65oiR5q2j5Zyo5Yip55So
57+76K+R57uZ5L2g5YaZ5L+h44CCDQoNCuaIkeaYr+WIqeS6muWnhsK35L2p5oGp5Lit5aOr5aSr
5Lq644CCDQrlnKjnvo7lm73pmYblhpvnmoTlhpvkuovpg6jpl6jjgILnvo7lm73vvIzkuIDlkI3k
uK3lo6vvvIwzMiDlsoHvvIzmiJHljZXouqvvvIzmnaXoh6rnvo7lm73nlLDnurPopb/lt57lhYvl
iKnlpKvlhbDvvIznm67liY3pqbvmiY7lnKjlj5nliKnkuprvvIzkuI7mgZDmgJbkuLvkuYnkvZzm
iJjjgILmiJHnmoTljZXkvY3mmK/nrKw05oqk55CG6Zif56ysNzgy5peF5L+d6Zqc6JCl44CCDQoN
CuaIkeaYr+S4gOS4quWFhea7oeeIseW/g+OAgeivmuWunuWSjOa3seaDheeahOS6uu+8jOWFt+ac
ieiJr+WlveeahOW5vem7mOaEn++8jOaIkeWWnOasoue7k+ivhuaWsOaci+WPi+W5tuS6huino+S7
luS7rOeahOeUn+a0u+aWueW8j++8jOaIkeWWnOasoueci+WIsOWkp+a1t+eahOazoua1quWSjOWx
seiEieeahOe+juS4veS7peWPiuWkp+iHqueEtuaJgOaLpeacieeahOS4gOWIh+aPkOS+m+OAguW+
iOmrmOWFtOiDveabtOWkmuWcsOS6huino+aCqO+8jOaIkeiupOS4uuaIkeS7rOWPr+S7peW7uuer
i+iJr+WlveeahOWVhuS4muWPi+iwiuOAgg0KDQrmiJHkuIDnm7TlvojkuI3lvIDlv4PvvIzlm6Dk
uLrov5nkupvlubTmnaXnlJ/mtLvlr7nmiJHkuI3lhazlubPvvJvmiJHlpLHljrvkuobniLbmr43v
vIzpgqPlubTmiJEgMjENCuWygeOAguaIkeeItuS6suWPq+S5lOWwlMK35L2p5oGp77yM5q+N5Lqy
5Y+r546b5Li9wrfkvanmganjgILmsqHmnInkurrluK7liqnmiJHvvIzkvYblvojpq5jlhbTmiJHn
u4jkuo7lnKjnvo7lhpvkuK3mib7liLDkuoboh6rlt7HjgIINCg0K5oiR57uT5ama55Sf5LqG5a2p
5a2Q77yM5L2G5LuW5q275LqG77yM5LiN5LmF5oiR5LiI5aSr5byA5aeL5qy66aqX5oiR77yM5omA
5Lul5oiR5LiN5b6X5LiN5pS+5byD5ama5ae744CCDQoNCuaIkeS5n+W+iOW5uOi/kO+8jOWcqOaI
keeahOWbveWutuOAgee+juWbveWSjOWPmeWIqeS6mui/memHjO+8jOaLpeacieaIkeeUn+a0u+S4
remcgOimgeeahOS4gOWIh++8jOS9huayoeacieS6uue7meaIkeW7uuiuruOAguaIkemcgOimgeS4
gOS4quivmuWunueahOS6uuadpeS/oeS7u++8jOS7luS5n+S8muWwseWmguS9leaKlei1hOWQkeaI
keaPkOS+m+W7uuiuruOAguWboOS4uuaIkeaYr+aIkeeItuavjeWcqOS7luS7rOWOu+S4luWJjeeU
n+S4i+eahOWUr+S4gOWls+WtqeOAgg0KDQrmiJHkuI3orqTor4bkvaDmnKzkurrvvIzkvYbmiJHo
rqTkuLrmnInkuIDkuKrlgLzlvpfkv6HotZbnmoTlpb3kurrvvIzku5blj6/ku6Xlu7rnq4vnnJ/m
raPnmoTkv6Hku7vlkozoia/lpb3nmoTllYbkuJrlj4vosIrvvIzlpoLmnpzkvaDnnJ/nmoTmnInk
uIDkuKror5rlrp7nmoTlkI3lrZfvvIzmiJHkuZ/mnInkuIDkupvkuJzopb/opoHlkozkvaDliIbk
uqvnm7jkv6HjgILlnKjkvaDouqvkuIrvvIzlm6DkuLrmiJHpnIDopoHkvaDnmoTluK7liqnjgILm
iJHmi6XmnInmiJHlnKjlj5nliKnkuprov5nph4zotZrliLDnmoTmgLvpop3vvIg1NTANCuS4h+e+
juWFg++8ieOAguaIkeS8muWcqOS4i+S4gOWwgeeUteWtkOmCruS7tuS4reWRiuivieS9oOaIkeaY
r+WmguS9leWBmuWIsOeahO+8jOS4jeimgeaDiuaFjO+8jOS7luS7rOaYr+aXoOmjjumZqeeahO+8
jOaIkei/mOWcqOS4jiBSZWQNCuacieiBlOezu+eahOS6uumBk+S4u+S5ieWMu+eUn+eahOW4ruWK
qeS4i+Wwhui/meeslOmSseWtmOWFpeS6humTtuihjOOAguaIkeW4jOacm+aCqOWwhuiHquW3seS9
nOS4uuaIkeeahOWPl+ebiuS6uuadpeaOpeaUtuWfuumHkeW5tuWcqOaIkeWcqOi/memHjOWujOaI
kOWQjuehruS/neWug+eahOWuieWFqOW5tuiOt+W+l+aIkeeahOWGm+S6i+mAmuihjOivgeS7peWc
qOaCqOeahOWbveWutuS4juaCqOS8mumdou+8m+S4jeimgeWus+aAlemTtuihjOS8muWwhui1hOmH
keWtmOWCqOWcqA0KQVRNIFZJU0Eg5Y2h5Lit77yM6L+Z5a+55oiR5Lus5p2l6K+05piv5a6J5YWo
5LiU5b+r5o2355qE44CCDQoNCueslOiusDvmiJHkuI3nn6XpgZPmiJHku6zopoHlnKjov5nph4zl
kYblpJrkuYXvvIzmiJHnmoTlkb3ov5DvvIzlm6DkuLrmiJHlnKjov5nph4zkuKTmrKHngrjlvLno
oq3lh7vkuK3lubjlrZjkuIvmnaXvvIzov5nlr7zoh7TmiJHlr7vmib7kuIDkuKrlgLzlvpfkv6Ho
tZbnmoTkurrmnaXluK7liqnmiJHmjqXmlLblkozmipXotYTln7rph5HvvIzlm6DkuLrmiJHlsIbm
naXliLDkvaDku6znmoTlm73lrrblh7rouqvmipXotYTvvIzlvIDlp4vmlrDnlJ/mtLvvvIzkuI3l
ho3lvZPlhbXjgIINCg0K5aaC5p6c5oKo5oS/5oSP6LCo5oWO5aSE55CG77yM6K+35Zue5aSN5oiR
44CC5oiR5Lya5ZGK6K+J5L2g5LiL5LiA5q2l55qE5rWB56iL77yM5bm257uZ5L2g5Y+R6YCB5pu0
5aSa5YWz5LqO5Z+66YeR5a2Y5YWl6ZO26KGM55qE5L+h5oGv44CC5Lul5Y+K6ZO26KGM5bCG5aaC
5L2V5biu5Yqp5oiR5Lus6YCa6L+HIEFUTSBWSVNBDQpDQVJEIOWwhui1hOmHkei9rOenu+WIsOaC
qOeahOWbveWuti/lnLDljLrjgILlpoLmnpzkvaDmnInlhbTotqPvvIzor7fkuI7miJHogZTns7vj
gIINCg==
